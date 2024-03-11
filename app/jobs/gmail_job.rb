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
        company = Company.find_or_create_by(name: job_detail["company_name"])
        job_application_attrs = job_detail.except("company_name").merge(company_id: company.id, user_id: current_user.id)
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
    openai_service = OpenaiService.new(email_data);
    response = openai_service.call(email_data);
    job_application_array = [];
  
    begin
      parsed_response = JSON.parse(response);
      job_application_array.push(parsed_response);
      return job_application_array;
    rescue JSON::ParserError => e
      puts "Erreur lors du parsing JSON: #{e.message}";
      return nil;
    end
  end
end

 # def find_or_create_job_application(job_detail, current_user)
  #   company = Company.find_or_create_by(name: job_detail["company_name"])
  # 
  #   job_application_attrs = job_detail.except("company_name").merge(company_id: company.id, user_id: current_user.id)
  # 
  #   job_application = JobApplication.where(user_id: current_user.id, company_id: company.id, job_title: job_application_attrs["job_title"]).first_or_initialize
  # 
  #   job_application.assign_attributes(job_application_attrs)
  # 
  #   job_application.save if job_application.new_record? || job_application.changed?
  # 
  #   job_application
  # end
  # 
  # def update_job_application(job_application, job_details)
  #   job_application.update(job_details.except("company_name"))
  # end  
