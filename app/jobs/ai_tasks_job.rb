class AiTasksJob < ApplicationJob
  queue_as :default

  def perform(user_id)

  user = User.find(user_id)

  # Adding all past interactions of the user to the prompt
  interactions = Interaction.includes(:interaction_contacts).where(user_id: user_id)

  contact_ids = interactions.flat_map do |interaction|
    interaction.interaction_contacts.pluck(:contact_id)
  end.uniq

  # Fetch all unique contacts based on the collected contact_ids
  contacts = Contact.where(id: contact_ids)

  # Retrieve the job_applications of the current user
  job_applications = JobApplication.includes(:company, tasks: []).where(user_id: user_id)

  # Construct a string with contact names (or other details you find relevant)
  contact_details = contacts.map { |contact| "#{contact.name} (#{contact.job_title} at #{contact.company.name})" }.join(', ')

  # Simplify and focus the prompt for clarity and directness
  prompt = <<~PROMPT
    #{user.fullname} is actively seeking employment Based on their current job applications and recent interactions below :

    - #{user.fullname} Applied to #{job_applications.size} positions including roles at #{job_applications.map { |app| app.company.name }.uniq.join(', ')} as #{job_applications.map { |app| app.job_title }.uniq.join(', ')}, that have respectively these id #{job_applications.map(&:id).join(', ')}.
    - #{user.fullname} Engaged in #{interactions.size} recent interactions related to job applications, including interviews and follow-ups.
    - The contacts that #{user.fullname} discussed with are: #{contact_details}

    Objective:
    Create a list of 5 actionable, specifically linked to each job application, tasks for this week to maximize #{user.fullname} chance of having an offer in the coming two months.
   PROMPT

    puts "--------your prompt is here : #{prompt}"

    begin

      #instantiating the service all to openAI
      openai_service = OpenaiService.new


      response_content = openai_service.taskCall(prompt)
      tasks_array = JSON.parse(response_content)


      tasks_array.each do |task|
        Task.create!(
          job_application_id: task['job_application_id'],
          name: task['name'],
          description: task['description'],
          status: :pending
        )
      end

    rescue => error

      Rails.logger.error "Failed to call OpenAI service: #{error.message}"

    end
  end
end
