class GmailJob < ApplicationJob
  queue_as :default


  def perform(current_user)

    interactions = current_user.interactions
    
    url = 'https://gmail.googleapis.com/gmail/v1/users/me/messages'
    headers = { "Authorization" => "Bearer #{current_user.access_token}" }

    url_message_gmail = "https://gmail.googleapis.com/gmail/v1/users/me/messages/"
    headers_message_gmail = { "Authorization" => "Bearer #{ current_user.access_token }" }

    response = HTTParty.get(url, headers: headers)

    puts "Response Code: #{response.code}"
      if response.success?
        # 
        p "-----------------------------------------------------"
        p "BODY ->>>>>>>>>>>"
        messages = response["messages"]
        puts messages
        p "-----------------------------------------------------"

        call_message = HTTParty.get(url_message_gmail + messages[3]["id"], headers: headers_message_gmail)
        puts "Response Body:"
        email_data = call_message.parsed_response # Supposons que cela contient l'objet JSON de votre exemple
        html_part = email_data["payload"]["parts"].find { |part| part["mimeType"] == "text/html" }
        base64_data = html_part["body"]["data"] if html_part
        puts base64_data
      else
        puts "Error: #{response.message}"
    end
  end
end