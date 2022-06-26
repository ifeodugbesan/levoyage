# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

ActsAsTaggableOn::Tag.destroy_all
Alternative.destroy_all
Issue.destroy_all
User.destroy_all


user = User.create!(email: 'ife@gmail.com', password: 123456)
sarah = User.create!(email: 'sarah@gmail.com', password: 123456)
50.times do
  User.create!(email: Faker::Internet.email, password: 123456)
end

puts 'created users'

tags = []

tag1 = ActsAsTaggableOn::Tag.create(name: 'ruby')
tags << tag1
tag2 = ActsAsTaggableOn::Tag.create(name: 'rails')
tags << tag2
tag3 = ActsAsTaggableOn::Tag.create(name: 'javascript')
tags << tag3
tag4 = ActsAsTaggableOn::Tag.create(name: 'html')
tags << tag4
tag5 = ActsAsTaggableOn::Tag.create(name: 'css')
tags << tag5
tag6 = ActsAsTaggableOn::Tag.create(name: 'rails')
tags << tag6
tag7 = ActsAsTaggableOn::Tag.create(name: 'github')
tags << tag7
tag8 = ActsAsTaggableOn::Tag.create(name: 'heroku')
tags << tag8

30.times do
  tag = ActsAsTaggableOn::Tag.create(name: Faker::DcComics.hero.downcase)
  tags << tag
  puts "created the tag #{tag.name}"
end

50.times do
  issue = Issue.new(
                title: Faker::DcComics.title,
                error_message: Faker::Movie.quote,
                content: Faker::Quote.famous_last_words,
                user: user
              )

  # CREATING TAGS FOR ISSUES
  tags.sample((0..12).to_a.sample).each do |tag|
    issue.tag_list.add(tag)
  end

  issue.save!

  # CREATING VOTES
  (0..100).to_a.sample.times do
    issue.liked_by User.all.sample
  end

  puts "created the issue #{issue.title}"
end


