# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create!(email: 'ife@gmail.com', password: 123456)
puts 'created user'

Issue.create!(
              title: "Can’t run yarn build —watch",
              error_message: "error Command 'build' not found.",
              content: "It's possible that you may be missing a script in your package.json which allows you to run build.
                        Try adding this code into the object in your package.json",
              user: user
            )
puts 'created issue'
