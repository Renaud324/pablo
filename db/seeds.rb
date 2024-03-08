
# ########################-CLEANING-###########################
puts "cleaning all the databases seeds"
InteractionContact.destroy_all
Interaction.destroy_all
Task.destroy_all
JobApplication.destroy_all
Contact.destroy_all
Company.destroy_all
User.destroy_all

# ########################-USER-###########################
puts "seeding the user"
user1 = User.create!(
  email: 'olele@example.com',
  password: 'password',
  first_name: 'John',
  last_name: 'Doe'
)

user2 = User.create!(
  email: 'olele2@example.com',
  password: 'password',
  first_name: 'Patrick',
  last_name: 'Martin'
)

company1 = Company.create!(
  name: 'Monday.com',
  company_link: 'https://www.monday.com'
)

# ########################-COMPANIES-###########################
puts "seeding the companies"

company2 = Company.create(
  name: 'Tech Innovations',
  company_link: 'https://techinnovations.com'
  )

company3 = Company.create(
  name: 'Health Solutions',
  company_link: 'https://healthsolutions.com'
  )

# ########################-CONTACTS-###########################
puts "seeding the contacts"

contact1 = Contact.create(
  email: 'contact1@company1.com',
  phone_number: '123-456-7890',
  company: company2
  )

contact2 = Contact.create(
  email: 'contact2@company2.com',
  phone_number: '098-765-4321',
  company: company3)

# ########################-APPLICATIONS-###########################
puts "seeding the applications"

job_application1 = JobApplication.create!(
  job_title: 'Software Engineer',
  offer_link: 'https://www.companya.com/job/123',
  status: 'First Interview',
  job_location: 'New York',
  notes: 'Application sent',
  job_description: 'Description of the job...',
  salary: 80000,
  application_source: 'LinkedIn',
  user: user1,
  company: company1
)


job_application2 = JobApplication.create!(
  application_start_date: Date.today,
  job_title: 'Software Engineer',
  offer_link: 'https://jobs.example.com/se',
  status: 'Just Applied',
  job_location: 'Remote',
  notes: 'First round interview completed.',
  job_description: 'Develop and maintain web applications.',
  salary: 85000.0,
  application_source: 'LinkedIn',
  user: user1,
  company: company2
  )

job_application3 = JobApplication.create!(
  application_start_date: Date.today - 5,
  job_title: 'Product Manager',
  offer_link: 'https://jobs.example.com/pm',
  status: 'Advanced Process',
  job_location: 'New York, NY',
  notes: 'Awaiting response.',
  job_description: 'Lead product development teams.',
  salary: 95000.0,
  application_source: 'Indeed',
  user: user1,
  company: company3
)

job_application4 = JobApplication.create!(
  application_start_date: Date.today - 5,
  job_title: 'Product Owner',
  offer_link: 'https://jobs.example.com/pm',
  status: 'Just Applied',
  job_location: 'Paris',
  notes: 'Awaiting response.',
  job_description: 'Lead product development teams.',
  salary: 100000,
  application_source: 'Indeed',
  user: user1,
  company: company3
)

job_application5 = JobApplication.create!(
  application_start_date: Date.today - 5,
  job_title: 'Junior Dev',
  offer_link: 'https://jobs.example.com/pm',
  status: 'Just Applied',
  job_location: 'Madrid',
  notes: 'Awaiting response.',
  job_description: 'Lead product development teams.',
  salary: 30000,
  application_source: 'Indeed',
  user: user1,
  company: company2
)

job_application6 = JobApplication.create!(
  application_start_date: Date.today - 5,
  job_title: 'Fullstack Dev',
  offer_link: 'https://jobs.example.com/pm',
  status: 'offer',
  job_location: 'London',
  notes: 'Awaiting response.',
  job_description: 'Lead product development teams.',
  salary: 60000,
  application_source: 'Linkedin',
  user: user1,
  company: company1
)

# ########################-TASKS-###########################
puts "seeding the tasks"

task1 = Task.create!(
  name: 'Update Resume',
  description: 'Revise and update my resume to better match the job requirements.',
  deadline_date: Date.today + 7,
  status: :pending, # using the enum
  completion_date: nil,
  job_application: job_application1
)

task2 = Task.create!(
  name: 'Prepare for Interview',
  description: 'Research the company and prepare answers to common interview questions.',
  deadline_date: Date.today + 3,
  status: :in_progress,
  completion_date: nil,
  job_application: job_application1
)

task3 = Task.create!(
  name: 'Send Follow-up Email',
  description: 'Draft and send a follow-up email thanking the interviewer for their time.',
  deadline_date: Date.today + 1,
  status: :pending,
  completion_date: nil,
  job_application: job_application2
)

task4 = Task.create!(
  name: 'Review Product Portfolio',
  description: 'Review and update the product portfolio to include the latest projects.',
  deadline_date: Date.today + 14,
  status: :pending,
  completion_date: nil,
  job_application: job_application3
)

# ########################-INTERACTIONS-###########################
puts "seeding the interactions"

interaction1 = Interaction.create(
  headline: 'Initial phone interview',
  event_date: Date.today - 2,
  event_time: '10:00',
  location: 'Zoom',
  interaction_type: 1,
  user: user1,
  job_application: job_application1
  )

interaction2 = Interaction.create(
  headline: 'Follow-up Meeting',
  event_date: Date.today - 1,
  event_time: '14:00',
  location: 'Berlin',
  interaction_type: 5,
  user: user1,
  job_application: job_application2
)

interaction3 = Interaction.create(
  headline: 'On-site interview',
  event_date: Date.today + 3,
  event_time: '14:00',
  location: 'Paris',
  interaction_type: 2,
  user: user1,
  job_application: job_application2
)

interaction4 = Interaction.create(
  headline: 'On-site technical interview',
  event_date: Date.today + 15,
  event_time: '14:00',
  location: 'London',
  interaction_type: 5,
  user: user1,
  job_application: job_application2
)

interaction5 = Interaction.create(
  headline: 'Call with HR',
  event_date: Date.today + 15,
  event_time: '14:00',
  location: '',
  interaction_type: 1,
  user: user1,
  job_application: job_application2
)

interaction6 = Interaction.create(
  headline: 'Call with HR',
  event_date: Date.today + 15,
  event_time: '14:00',
  location: '',
  interaction_type: 1,
  user: user2,
  job_application: job_application6
)

# ########################-INTERACTIONS/CONACTS-###########################
puts "linking interactions and contacts"
InteractionContact.create(contact: contact1, interaction: interaction1)
InteractionContact.create(contact: contact2, interaction: interaction2)
InteractionContact.create(contact: contact2, interaction: interaction3)

puts "finished seeding"
