class EmailProcessorJob
  include Sidekiq::Job

  def perform(user_id)

    user = User.find(user_id)

    # Initialize the Gmail service
    service = Google::Apis::GmailV1::GmailService.new

    # Obtain a new access token with the refresh token
    if user.needs_refresh?
      new_access_token = get_new_access_token(user.refresh_token)
      user.update(access_token: new_access_token)
    end

    # Assign the user's access token to the service
    service.authorization = user.access_token

    # Fetch emails with specific keywords
    query = 'subject:job offer OR subject:application'

    result = service.list_user_messages('me', q: query)

    #stores the result in the 
  end

  private

    def get_new_access_token(refresh_token)
      # Code to exchange refresh token for a new access token
      # You'd typically make a request to Google's OAuth2 token endpoint
    end

end
