# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ActsAsTaggableOn::Tag.destroy_all
Issue.destroy_all
User.destroy_all


user = User.create!(email: 'ife@gmail.com', password: 123456)
puts 'created user'

tag1 = ActsAsTaggableOn::Tag.create(name: 'ruby')
tag2 = ActsAsTaggableOn::Tag.create(name: 'rails')
tag3 = ActsAsTaggableOn::Tag.create(name: 'javascript')
tag4 = ActsAsTaggableOn::Tag.create(name: 'html')
tag5 = ActsAsTaggableOn::Tag.create(name: 'css')
tag6 = ActsAsTaggableOn::Tag.create(name: 'rails')
puts 'created tags'

issue = Issue.new(
              title: "Can’t run yarn build —watch",
              error_message: "error Command 'build' not found.",
              content: "It's possible that you may be missing a script in your package.json which allows you to run build.
                        Try adding this code into the object in your package.json",
              user: user
            )

issue.tag_list.add(tag1)
issue.tag_list.add(tag2)
issue.tag_list.add(tag3)
issue.tag_list.add(tag4)
issue.tag_list.add(tag5)
issue.tag_list.add(tag6)

issue.save!

puts 'created issue'

