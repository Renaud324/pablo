# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user1 = User.create!(
  email: 'user1@example.com',
  password: 'password',
  first_name: 'John',
  last_name: 'Doe'
)

company1 = Company.create!(
  name: 'Company A',
  company_link: 'https://www.companya.com'
)

JobApplication.create!(
  job_title: 'Software Engineer',
  offer_link: 'https://www.companya.com/job/123',
  status: 'Pending',
  job_location: 'New York',
  notes: 'Interview scheduled for next week',
  job_description: 'Description of the job...',
  salary: 80000,
  application_source: 'LinkedIn',
  user: user1,
  company: company1
)
