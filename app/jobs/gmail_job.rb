require "nokogiri"
class GmailJob < ApplicationJob
  queue_as :default

  def perform(current_user)
    p current_user
    url = 'https://gmail.googleapis.com/gmail/v1/users/me/messages'
    headers = { "Authorization" => "Bearer #{current_user.access_token}" }

    response = HTTParty.get(url, headers: headers)
    if response.success?
      messages = response["messages"]

      messages.each do |message|
        process_message(message, headers, current_user)
      end
    else
      puts "Error: #{response.message}"
    end
  end

  private

  def process_message(message, headers)
    url_message_gmail = "https://gmail.googleapis.com/gmail/v1/users/me/messages/#{message["id"]}"
    call_message = HTTParty.get(url_message_gmail, headers: headers)
    if call_message.success?
      html_part = call_message.parsed_response["payload"]["parts"].find { |part| part["mimeType"] == "text/html" }
      if html_part
        decoded_data = Base64.urlsafe_decode64(html_part["body"]["data"])
        job_detail(decoded_data, message["id"], current_user)
      end
    else
      puts "Error fetching message: #{call_message.message}"
    end
  end

  def job_detail(email_data, message_id, current_user)
    doc = Nokogiri::HTML(email_data)
    
    job_offer_regex = /applying to the\s+(.+?)\s+at\s+(.+?)\s+\((https?:\/\/.+?)\)/
    location_salary_regex = /located in\s+(.+?)\.\s*The salary is\s*([\d,]+\$\/year)/
    # Ajustement pour arrêter la capture à "Bangalore, India" sans inclure le texte suivant
    job_location_regex = /located in\s+([\w\s]+),\s*([\w\s]+)\./
  
    email_text = Nokogiri::HTML(email_data).text.gsub('Â', '').gsub(/[[:space:]]/, ' ').squish
    
    job_offer_match = email_text.match(job_offer_regex)
    job_location_match = email_text.match(job_location_regex)
    location_salary_match = email_text.match(location_salary_regex)
    
    job_title = job_offer_match ? job_offer_match[1].strip : "Unknown"
    company_name = job_offer_match ? job_offer_match[2].strip : "Unknown"
    offer_link = job_offer_match ? job_offer_match[3].strip : "Unknown"
    job_location = job_location_match ? "#{job_location_match[1].strip}, #{job_location_match[2].strip}" : "Unknown"
    salary = location_salary_match ? location_salary_match[2].gsub('$', '').gsub('/year', '').delete(',').to_i : 0
    
    email_content = {
      job_title: job_title,
      company_name: company_name,
      offer_link: offer_link,
      job_location: job_location,
      salary: salary,
      status: 'Just applied',
    }
    
    puts email_content
    handle_interaction_and_application(message_id, email_content, current_user)
  end
  
  
  def handle_interaction_and_application(message_id, job_details, current_user)
    interaction = Interaction.find_by(email_id: message_id)
    if interaction
      update_job_application(interaction.job_application_id, job_details)
    else
      job_application = create_job_application(job_details, current_user)
      create_interaction(message_id, job_application.id, current_user)
    end
  end

  def create_job_application(job_details, current_user)
    job_application = JobApplication.new(
      application_start_date: Time.current,
      job_title: job_details[:job_title],
      offer_link: job_details[:offer_link],
      status: job_details[:status],
      job_location: job_details[:job_location],
      salary: job_details[:salary],
      application_source: 'Gmail', 
      user_id: current_user.id
    )
    if job_application.save
      job_application
    else
      puts "Erreur lors de la création de l'application de travail"
      nil
    end
  end
  
  def update_job_application(job_application_id, job_details)
    job_application = JobApplication.find_by(id: job_application_id)
    if job_application
      job_application.update(
        # update ici
      )
    else
      puts "Application de travail non trouvée"
    end
  end
  
  def create_interaction(email_id, job_application_id, current_user)
    Interaction.create(
      email_id: email_id,
      job_application_id: job_application_id,
      user_id: current_user.id,
    )
  end
end
