# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.delete_all
Resource.delete_all
ResourceTag.delete_all
Tag.delete_all

student_users = 20.times.map do
  User.create!(email: Faker::Internet.email,
    password_hash: 'password',
    role: 'student')
end

teacher_users = 10.times.map do
  User.create!(email: Faker::Internet.email,
    password_hash: 'password',
    role: 'teacher')
end

resources = 5.times.map do
  teacher_users.each do |teacher|
    teacher.resources.create!(title: Faker::Lorem.word,
      creator_id: teacher.id)
  end
end

Tag.create(name: "Ruby")
Tag.create(name:"JavaScript")
Tag.create(name: "SQL")
Tag.create(name: "Python")

tagged_resources = Resource.all.each do |resource|
  num = Tag.all.sample.id
  ResourceTag.create!(resource_id: resource.id, tag_id: numra)
end
