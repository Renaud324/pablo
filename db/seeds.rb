
# ########################-CLEANING-###########################
puts "cleaning all the databases seeds"
InteractionContact.destroy_all
Interaction.destroy_all
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
  status: 'First Interview ',
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
  status: 'Just Applied ',
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
  status: '3. Advanced Process',
  job_location: 'New York, NY',
  notes: 'Awaiting response.',
  job_description: 'Lead product development teams.',
  salary: 95000.0,
  application_source: 'Indeed',
  user: user1,
  company: company3
  )

# ########################-INTERACTIONS-###########################
puts "seeding the interactions"

interaction1 = Interaction.create(
  headline: 'Initial Interview',
  event_date: Date.today - 2,
  event_time: '10:00',
  location: 'Zoom',
  interaction_type: 0,
  user: user1,
  job_application: job_application1
  )

interaction2 = Interaction.create(
  headline: 'Follow-up Meeting',
  event_date: Date.today - 1,
  event_time: '14:00',
  location: 'Zoom',
  interaction_type: 1,
  user: user1,
  job_application: job_application2
)

# ########################-INTERACTIONS/CONACTS-###########################
puts "linking interactions and contacts"
InteractionContact.create(contact: contact1, interaction: interaction1)
InteractionContact.create(contact: contact2, interaction: interaction2)

puts "finished seeding"
