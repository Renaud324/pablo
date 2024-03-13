# app/jobs/ai_tasks_job.rb
class AiTasksJob < ApplicationJob
  queue_as :default

  def perform(user_id)

    user = User.find(user_id)

    # Initialize an empty prompt
    prompt = "Job applications overview for #{user.fullname}:\n can you prepare a list of 5 tasks for me. my objective is to find a job a move my current applications to the next level  my goal is to have an offer. here you can find all my current activities"

    # Fetch job applications for the user
    job_applications = JobApplication.includes(:company, tasks: []).where(user_id: user_id)

    # Constructing the prompt for job applications and tasks
    job_applications.each do |application|
      prompt += "Job Application: #{application.job_title}, Company: #{application.company.name}, Status: #{application.status}, Location: #{application.job_location}\n"

      # Tasks related to the job application
      application.tasks.each do |task|
        prompt += "  Task: #{task.name}, Description: #{task.description}, Deadline: #{task.deadline_date}, Status: #{task.status}\n"
      end
    end

    # Interactions associated with the user
    interactions = Interaction.includes(:interaction_contacts).where(user_id: user_id)

    prompt += "Interactions:\n"
    interactions.each do |interaction|
      prompt += " Interaction: #{interaction.headline}, Type: #{interaction.interaction_type}, Date: #{interaction.event_date}, Location: #{interaction.location}\n"

      # Contacts involved in the interaction
      interaction.interaction_contacts.each do |interaction_contact|
        contact = Contact.find(interaction_contact.contact_id)
        prompt += "    Contact: #{contact.name}, Job Title: #{contact.job_title}, Company: #{Company.find(contact.company_id).name}\n"
      end
    end


    puts "--------your prompt is here : #{prompt}"

    openai_service = OpenaiService.new
    response = openai_service.call(prompt)
    puts "--------your response is here : #{response}"
  end
end
