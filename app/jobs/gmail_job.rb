class GmailJob < ApplicationJob
  queue_as :default

  def perform(current_user)

    p current_user


    
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