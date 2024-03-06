class GmailJob < ApplicationJob
  queue_as :default


  def perform(current_user)

    interactions = current_user.interactions


    # Définir l'URL de l'API et le header d'autorisation
    url = 'https://gmail.googleapis.com/gmail/v1/users/me/messages'
    headers = { "Authorization" => "Bearer #{current_user.access_token}" }

    url_message_gmail = "https://gmail.googleapis.com/gmail/v1/users/me/messages/"
    headers_message_gmail = { "Authorization" => "Bearer #{ current_user.access_token }" }

    # Effectuer la requête GET
    response = HTTParty.get(url, headers: headers)

    # Afficher la réponse
    puts "Response Code: #{response.code}"
    if response.success?
      # 
      p "-----------------------------------------------------"
      p "BODY ->>>>>>>>>>>"
      messages = response["messages"]
      puts messages
      p "-----------------------------------------------------"

      # messages = messages.reject { |message| interactions.pluck(:email_id).includes(message['id']) }

      p "-----------------------------------------------------"
      messages.each do |message|
        call_message = HTTParty.get(url_message_gmail + message["id"], headers: headers_message_gmail)
        puts "Response Body: #{call_message.body}"
      end
      p "-----------------------------------------------------"

    else
      # Gérer les réponses d'erreur
      puts "Error: #{response.message}"
  end
end


  private

  def get_new_access_token(refresh_token)
  client_id = ENV['GOOGLE_OAUTH_CLIENT_ID']

  token_credential_uri = 'https://oauth2.googleapis.com/token'

  # Initialize the Signet OAuth2 client
  client = Signet::OAuth2::Client.new(
    token_credential_uri: token_credential_uri,
    client_id:            client_id,
    client_secret:        client_secret,
    refresh_token:        refresh_token,
    grant_type:           refresh_token,
    additional_parameters: additional_parameters,
  )

  # Fetch new access token
  client.fetch_access_token!

  # Return the new access token
  client.access_token
  rescue => e
    # Handle error (e.g., logging)
    puts "Failed to refresh access token: #{e.message}"
    nil
  end
end


# user = User.find(user_id)
# 
    # # Initialize the Gmail service
    # service = Google::Apis::GmailV1::GmailService.new
# 
    # # Obtain a new access token with the refresh token
    # # if user.needs_refresh?
    # #   new_access_token = get_new_access_token(user.refresh_token)
    # #   user.update(access_token: new_access_token)
    # # end
# 
    # # Assign the user's access token to the service
    # service.authorization = user.access_token
# 
    # # Fetch emails with specific keywords
    # query = 'subject:job offer OR subject:application'
# 
    # result = service.list_user_messages('me', q: query)
# 
    # if result.messages
    #   result.messages.each do |message|
    #     puts message
    #   end
    # else
    #   puts "No messages found."
    # end