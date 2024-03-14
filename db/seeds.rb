
# ########################-CLEANING-###########################
puts "cleaning all the databases seeds"
InteractionContact.destroy_all
Interaction.destroy_all
Task.destroy_all
JobApplication.destroy_all
Contact.destroy_all
Company.destroy_all

# ########################-USER-###########################
puts "Finding the user..."
user1 = User.where(email: "aloha.alice.pablo@gmail.com").first

# ########################-COMPANIES-###########################
puts "seeding the companies"

company1 = Company.create!(
  name: 'Monday.com',
  company_link: 'https://www.monday.com'
)

company2 = Company.create!(
  name: 'Tech Innovations',
  company_link: 'https://techinnovations.com'
)

company3 = Company.create!(
  name: 'Google',
  company_link: 'https://google.com'
)

# ########################-CONTACTS-###########################
puts "seeding the contacts"

contact1 = Contact.create!(
  name: 'Adrien Lebriquier',
  email: 'adrien-hr@monday.com',
  phone_number: '123-456-7890',
  job_title: 'CEO',
  company: company1
)

contact2 = Contact.create!(
  name: 'Bobby Fisher',
  email: 'bob@techinnovations.com',
  phone_number: '123-456-7890',
  job_title: 'COO',
  company: company2
)

contact3 = Contact.create!(
  name: 'Sergey Brin',
  email: 'recrutement@google.com',
  phone_number: '098-765-4321',
  job_title: 'HR manager',
  company: company3
)

# ########################-APPLICATIONS-###########################
puts "seeding the applications"

job_application1 = JobApplication.create!(
  job_title: 'Next.js Back-end Developer',
  offer_link: 'https://fr.indeed.com/jobs?q=Next.js&l=Paris+%2875%29&start=10&vjk=6ace7e6212caca95',
  status: 0,
  job_location: 'New York',
  notes: 'Application sent',
  job_description: 'Develop and maintain web applications using Next.js. Next.js and React.js experience required. Supabase experience required, Docker and Kubernetes experience a plus. AWS experience a plus.',
  salary: 80,
  application_source: 'Indeed',
  user: user1,
  company: company1
)

job_application2 = JobApplication.create!(
application_start_date: Date.today,
job_title: 'Software Engineer',
offer_link: 'https://fr.indeed.com/jobs?q=Software+engineer&l=Paris+%2875%29&vjk=17e01ca92f35af51&advn=4200815118720440',
status: 0,
job_location: 'Remote',
notes: 'First round interview completed.',
job_description: 'Develop and maintain web applications.',
salary: 85
application_source: 'Indeed',
user: user1,
company: company2
)

job_application3 = JobApplication.create!(
application_start_date: Date.today - 5,
job_title: 'PHP Back-end Developer',
offer_link: 'https://www.welcometothejungle.com/fr/companies/sii/jobs/developpeur-php-back-end-f-h_sophia-antipolis?q=6788722412bf473880c78f3673414aaa&o=cb5d3fe9-7fc4-44e0-b297-d0dfb4e8f15b',
status: 0,
job_location: 'New York, NY',
notes: 'Awaiting response.',
job_description: 'Develop and maintain web applications using PHP. Laravel experience required. Docker and Kubernetes experience a plus. AWS experience a plus.',
salary: 85,
application_source: 'Welcome to the jungle',
user: user1,
company: company3
)

job_application4 = JobApplication.create!(
application_start_date: Date.today - 5,
job_title: 'Node.js Back-end Developer',
offer_link: 'https://www.welcometothejungle.com/fr/companies/agorastore-1/jobs/developpeur-senior-backend-node-js-h-f_montreuil?q=afde50d21e921b4f9ac1738c08a46a44&o=fdd49676-d091-4505-8e10-0690b57d61c3',
status: 0,
job_location: 'New York, NY',
notes: 'Awaiting response.',
job_description: 'Develop and maintain web applications using Node.js. Nest.js experience required. Docker and Kubernetes experience a plus. AWS experience a plus.',
salary: 75,
application_source: 'Welcome to the jungle',
user: user1,
company: company1
)

job_application5 = JobApplication.create!(
application_start_date: Date.today - 5,
job_title: 'Rust Developer',
offer_link: 'https://www.welcometothejungle.com/fr/companies/stormshield/jobs/developpeur-rust-h-f_lille?q=1bc281bcb2dba4dc5024fcd369db9317&o=50e77273-9b76-4de5-b208-6b47e2a0705e',
status: 0,
job_location: 'New York, NY',
notes: 'Awaiting response.',
job_description: 'Develop and maintain web applications using Rust. Actix experience required. Docker and Kubernetes experience a plus. AWS experience a plus.',
salary: 140,
application_source: 'Welcome to the jungle',
user: user1,
company: company2
)

job_application6 = JobApplication.create!(
application_start_date: Date.today - 5,
job_title: 'Product Manager',
offer_link: 'https://www.welcometothejungle.com/fr/companies/hubcycle/jobs/product-manager_avignon?q=7060af97573be2628b70b6c750bf44e8&o=587d862f-ddb2-45fb-8d2e-623a11f6908d',
status: 1,
job_location: 'New York, NY',
notes: 'Awaiting response.',
job_description: 'Lead product development teams.',
salary: 95,
application_source: 'Welcome to the jungle',
user: user1,
company: company3
)

job_application7 = JobApplication.create!(
application_start_date: Date.today - 5,
job_title: 'Product Owner',
offer_link: 'https://www.welcometothejungle.com/fr/companies/hellowork/jobs/product-owner-h-f_rennes_HELLO_wJGx9yD?q=5f0a3390a9a7146222e6257994ed60e9&o=f4593631-e9b1-4985-aa66-af9256a32125',
status: 1,
job_location: 'Paris',
notes: 'Awaiting response.',
job_description: 'Coordinate and lead product development teams to align with business goals and user needs. Define product vision, roadmap, and prioritize features. Conduct market research and gather feedback to drive product innovation and enhancements. Collaborate with stakeholders including engineering, design, and marketing to ensure successful product delivery. Facilitate communication and foster a collaborative environment within the team. Continuously monitor and analyze product performance metrics to iterate and improve product strategy.',
salary: 100,
application_source: 'Welcome to the jungle',
user: user1,
company: company1
)

job_application8 = JobApplication.create!(
application_start_date: Date.today - 5,
job_title: 'Junior React.js Developer',
offer_link: 'https://fr.indeed.com/jobs?q=React.js+junior&l=Paris+%2875%29&vjk=2b146900fbea55be',
status: 1,
job_location: 'Madrid',
notes: 'Awaiting response.',
job_description: 'Develop user interfaces using React.js. Collaborate with the development team to design and implement front-end features. Write clean, maintainable, and efficient code. Troubleshoot and debug issues to ensure smooth functionality. Stay updated on emerging technologies and best practices in web development.',
salary: 30,
application_source: 'Indeed',
user: user1,
company: company2
)

job_application9 = JobApplication.create!(
application_start_date: Date.today - 5,
job_title: 'Fullstack Developper (React.js/Spring Boot)',
offer_link: 'https://fr.indeed.com/jobs?q=react+spring+boots&l=Paris+%2875%29&vjk=45349f66f517445f&advn=4190676325902957',
status: 2,
job_location: 'Paris, France',
notes: 'Awaiting response.',
job_description: "Develop and maintain web applications using React.js and Spring Boot. Collaborate with cross-functional teams to define, design, and ship new features. Ensure the performance, quality, and responsiveness of applications. Identify and correct bottlenecks and fix bugs. Help maintain code quality, organization, and automatization.",
salary: 70,
application_source: 'Indeed',
user: user1,
company: company3
)

job_application10 = JobApplication.create!(
application_start_date: Date.today - 5,
job_title: 'Blockchain Developper',
offer_link: 'https://getapplicantai.com/synthr-ou/senior-smart-contract-developer/99?ref=web3.career#apply',
status: 2,
job_location: 'Remote',
notes: 'Awaiting response.',
job_description: 'Develop and maintain web applications using blockchain technology. Collaborate with cross-functional teams to define, design, and ship new features. Ensure the performance, quality, and responsiveness of applications. Identify and correct bottlenecks and fix bugs. Help maintain code quality, organization, and automatization.',
salary: 200,
application_source: 'Web3 Career',
user: user1,
company: company1
)
########################-TASKS-###########################

puts "seeding the tasks"

task1 = Task.create!(
name: 'Update Resume',
description: 'Revise and update my resume to better match the job requirements.',
deadline_date: Date.today + 7,
status: :pending,
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
########################-INTERACTIONS-###########################

puts "seeding the interactions"

interaction1 = Interaction.create!(
headline: 'Initial phone interview',
event_date: Date.today - 2,
event_time: '10:00',
location: 'Zoom',
interaction_type: 1,
user: user1,
job_application: job_application1
)

interaction2 = Interaction.create!(
headline: 'Follow-up Meeting',
event_date: Date.today - 1,
event_time: '14:00',
location: 'Berlin',
interaction_type: 5,
user: user1,
job_application: job_application2
)

interaction3 = Interaction.create!(
headline: 'On-site interview',
event_date: Date.today + 3,
event_time: '14:00',
location: 'Paris',
interaction_type: 2,
user: user1,
job_application: job_application3
)

interaction4 = Interaction.create!(
headline: 'On-site technical interview',
event_date: Date.today + 35,
event_time: '14:00',
location: 'London',
interaction_type: 5,
user: user1,
job_application: job_application4
)

interaction5 = Interaction.create!(
  headline: 'Call with HR',
  event_date: Date.today + 4,
  event_time: '14:00',
  location: '',
  interaction_type: 1,
  user: user1,
  job_application: job_application5
)

interaction6 = Interaction.create!(
  headline: 'Call with HR',
  event_date: Date.today + 25,
  event_time: '14:00',
  location: '',
  interaction_type: 1,
  user: user1,
  job_application: job_application6
)

interaction6 = Interaction.create!(
  headline: 'Call with HR',
  event_date: Date.today + 1,
  event_time: '14:00',
  location: '',
  interaction_type: 1,
  user: user1,
  job_application: job_application6
  )

  interaction7 = Interaction.create!(
    headline: 'Call with HR',
    event_date: Date.today + 7,
    event_time: '14:00',
    location: '',
    interaction_type: 1,
    user: user1,
    job_application: job_application7
    )

  interaction8 = Interaction.create!(
    headline: 'Call with HR',
    event_date: Date.today + 20,
    event_time: '14:00',
    location: '',
    interaction_type: 1,
    user: user1,
    job_application: job_application8
    )

  interaction9 = Interaction.create!(
    headline: 'Call with HR',
    event_date: Date.today + 5,
    event_time: '14:00',
    location: '',
    interaction_type: 1,
    user: user1,
    job_application: job_application9
  )

  interaction10 = Interaction.create!(
    headline: 'Call with HR',
    event_date: Date.today + 2,
    event_time: '14:00',
    location: '',
    interaction_type: 1,
    user: user1,
    job_application: job_application10
  )
########################-INTERACTIONS/CONACTS-###########################

puts "linking interactions and contacts"
InteractionContact.create!(contact: contact1, interaction: interaction1)
InteractionContact.create!(contact: contact2, interaction: interaction2)
InteractionContact.create!(contact: contact3, interaction: interaction3)
InteractionContact.create!(contact: contact1, interaction: interaction4)
InteractionContact.create!(contact: contact2, interaction: interaction5)
InteractionContact.create!(contact: contact3, interaction: interaction6)
InteractionContact.create!(contact: contact1, interaction: interaction7)
InteractionContact.create!(contact: contact2, interaction: interaction8)
InteractionContact.create!(contact: contact3, interaction: interaction9)
InteractionContact.create!(contact: contact1, interaction: interaction10)

puts "finished seeding"
