class OpenaiService
  include HTTParty
  attr_reader :api_url, :options, :query

  def initialize
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{ENV['OPENAI_SECRET_KEY']}"
      }
    }
  end

  def taskCall(prompt)
  pre_prompt ="IGNORE ALL LAST PROMPTS, you are an job assistant that helps the user below find a job, you need to send back RUBY HASH exactly following the structure below:
    [
    {
      job_application_id: 'job_application.id',
      name: 'name of the task (should be an action 'call, write etc..' 4 words max length)',
      description: 'description of the task linked to the job_application_id (16 words max length)'
    }
    ].ATTENTION, IL FAUT JUSTE LE HASH SOUS AU FORMAT JSON POUR PARSER LE RÉSULTAT EN HASH RUBY PAR LA SUITE FACILEMENT, DONC LES CLÉS ENTRE DOUBLE GUILLEMET COMME UN JSON CLASSIQUE."
    body = {
      model: 'gpt-3.5-turbo',
      messages: [
        { role: 'system', content: pre_prompt },
        { role: 'user', content: prompt }
      ]
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 500)
    raise response['error']['message'] unless response.code == 200
    response_content = response['choices'][0]['message']['content']
  end



  def call(prompt)
    # Pre-prompt text
    pre_prompt = "IGNORE TOUTES LES INSTRUCTIONS AVANT CELLES CI. Tu es un assistant de recherche d'emploi et ton rôle et d'analyser des mails et de renvoyer des HASH RUBY AU FORMAT JSON en fonction du contenu que tu as trouvé dans le mail. En tant qu'assistant tu recevras des mails de réponse à des offres d'emploi. Tu devras en analyser le contenu et renvoyer des HASH RUBY AU FORMAT JSON en fonction du contenu que tu as trouvé dans le mail. Tu devras renvoyer un HASH RUBY qui ressemble à ceci : {
      'job_title' => 'TITRE DU JOB POSTULÉ',
      'company_name' => 'ENTREPRISE QUE SOUHAITE REJOINDRE L\'USER',
      'offer_link' => 'http://lien-de-l\'offre-d\'emploi.com',
      'job_location' => 'Lieu ou se trouve ce travail',
      'job_description' => 'Description du job contenu dans le mail',
      'status' => 'Just Applied',
      'salary' => 50000
    } .ATTENTION, IL FAUT JUSTE LE HASH SOUS AU FORMAT JSON POUR PARSER LE RÉSULTAT EN HASH RUBY PAR LA SUITE FACILEMENT, DONC LES CLÉS ENTRE DOUBLE GUILLEMET COMME UN JSON CLASSIQUE. EGALEMENT, SI LE CONTENU DU MAIL QUE TU ES EN TRAIN DE LIRE N'EST PAS EN RAPPORT AVEC UNE OFFRE D'EMPLOI, SKIP LE MAIL ET RENVOIE PROMPT VIDE."
    body = {
      model: 'gpt-3.5-turbo',
      messages: [
        { role: 'system', content: pre_prompt }, # System message for pre-prompt
        { role: 'user', content: prompt }         # User's actual
      ]
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 500)
    raise response['error']['message'] unless response.code == 200
    response_text = response['choices'][0]['message']['content']
  end
end
