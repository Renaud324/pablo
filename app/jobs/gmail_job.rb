require "nokogiri"
class GmailJob < ApplicationJob
  queue_as :default

  def perform(current_user)
    fetch_and_process_emails(current_user)
  end

  private

  def fetch_and_process_emails(current_user)
    response = HTTParty.get(
      'https://gmail.googleapis.com/gmail/v1/users/me/messages',
      headers: { "Authorization" => "Bearer #{current_user.access_token}" }
    )
    if response.success?
      response.parsed_response["messages"].each do |email|
        process_email_thread(email["threadId"], current_user)
      end
    else
      puts "Error: #{response.message}"
    end
  end

  def process_email_thread(thread_id, current_user)  
    email_details = fetch_email_details(thread_id, current_user)
    job_details = analyse_thread_email(email_details)
  
    if job_details
      job_details.each do |job_detail|
        normalized_status = normalize_status(job_detail["status"])
        company = Company.find_or_create_by(name: job_detail["company_name"])
        job_application_attrs = job_detail.except("company_name", "status").merge(company_id: company.id, user_id: current_user.id, status: normalized_status)
        JobApplication.create(job_application_attrs)
      end
    end
  end
  
  def fetch_email_details(thread_id, current_user)
    response = HTTParty.get(
      "https://gmail.googleapis.com/gmail/v1/users/me/messages/#{thread_id}",
      headers: { "Authorization" => "Bearer #{current_user.access_token}" }
    );
  
    part = response['payload']['parts'].find { |p| p['mimeType'] == 'text/plain' };
    encoded_data = part['body']['data'] if part;
  
    if encoded_data
      decoded_data = Base64.urlsafe_decode64(encoded_data);
  
      return decoded_data;
    else
      puts "No plain text part found in the email."
    end
  end

  def analyse_thread_email(email_data)
    openai_service = OpenaiService.new(email_data)
    response = openai_service.call(email_data)
    job_application_array = []
  
    begin
      parsed_response = JSON.parse(response)
  
      if parsed_response.blank? || parsed_response['job_title'].blank?
        puts "Réponse vide ou ne contenant pas les informations nécessaires. Passage au suivant."
        return nil
      end
  
      puts "--------------------------------"
      puts "Parsed response: #{parsed_response}"
      puts "--------------------------------"
      job_application_array.push(parsed_response)
      return job_application_array
    rescue JSON::ParserError => e
      puts "Erreur lors du parsing JSON: #{e.message}"
      return nil
    end
  end

  def normalize_status(status)
    case status
    when "Just Applied"
      :just_applied
    when "First Interview"
      :first_interview
    when "Advanced"
      :advanced
    when "Offer"
      :offer
    else
      :just_applied
    end
  end
  
end
