require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'mail'

class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(interaction, user)

    service = initialize_gmail_service(user)

    puts "#1-this is your gmail instance : #{service}"

    contact_email = interaction.contacts.first&.email

    puts "#2-this is your contact email : #{contact_email}"

    puts "#3-this is your access token : #{user.access_token}"

    message = Mail.new do
      To contact_email
      from user.email
      subject interaction.headline
      body interaction.email_content
    end

    puts "#4-this is your message : #{message}"

    message_delivery = message.encoded
    message_base64 = Base64.urlsafe_encode64(message_delivery)

    puts "#5-this is your message_base64 : #{message_base64}"

    begin
      message_object = Google::Apis::GmailV1::Message.new(raw: message_base64)
        puts "#6-this is your message_object : #{message_object}"
      result = service.send_user_message('me', message_object)
        puts "#7-this is your result : #{result.id}"
    rescue Google::Apis::Error => e
      puts "#8-this is your error message : #{e.message}"
    result = nil
    end
    result
  end

private

def initialize_gmail_service(user)
  authorizer = Google::Auth::UserRefreshCredentials.new(
    client_id: ENV['GOOGLE_OAUTH_CLIENT_ID'],
    client_secret: ENV['GOOGLE_OAUTH_CLIENT_SECRET'],
    scope: Google::Apis::GmailV1::AUTH_GMAIL_SEND,
    redirect_uri: 'http://localhost:3000/users/auth/google_oauth2/callback',
    refresh_token: user.refresh_token
  )

  service = Google::Apis::GmailV1::GmailService.new
  service.client_options.application_name = 'Pablo web app'
  service.authorization = authorizer

  service
end

end
