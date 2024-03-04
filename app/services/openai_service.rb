class OpenaiService
  include HTTParty
  attr_reader :api_url, :options, :query

  def initialize(query)
    @query = query
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{ENV['OPENAI_SECRET_KEY']}"
      }
    }
  end

  def call
    # Pre-prompt text
    pre_prompt = "Please provide a detailed explanation for the following question:"
    body = {
      model: 'gpt-3.5-turbo', # Model can be changed
      messages: [
        { role: 'system', content: pre_prompt }, # System message for pre-prompt
        { role: 'user', content: query }         # User's actual query
      ]
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 500)
    raise response['error']['message'] unless response.code == 200
    response_text = response['choices'][0]['message']['content']
    puts response_text
  end
end
