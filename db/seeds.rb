# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"
require 'faker'

ActsAsTaggableOn::Tag.destroy_all
Alternative.destroy_all
Issue.destroy_all
Resource.destroy_all
User.destroy_all

# CREATING USERS
user = User.create!(email: 'ife@gmail.com', password: 123456)
sarah = User.create!(email: 'sarah@gmail.com', password: 123456)
50.times do
  User.create!(email: Faker::Internet.email, password: 123456)
end

puts 'created users'

# CREATING TAGS
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

# CREATING ISSUES
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


# CREATING RESOURCES

resource = Resource.new(
                    title: "Coolors",
                    description: "The super fast color schemes generator! Create, save and share perfect palettes in seconds!",
                    link: "https://coolors.co/",
                    user: user
                  )

resource.tag_list.add("colors")
resource.tag_list.add("front-end")
resource.tag_list.add("design")
resource.tag_list.add("style")
resource.tag_list.add("css")


file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423925/Le%20voyage/coolors.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Color Hunt",
                    description: "Color Hunt is a free and open platform for color inspiration with thousands of trendy hand-picked color palettes.",
                    link: "https://colorhunt.co/",
                    user: user
                  )

resource.tag_list.add("colors")
resource.tag_list.add("front-end")
resource.tag_list.add("design")
resource.tag_list.add("style")
resource.tag_list.add("css")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423926/Le%20voyage/color-hunt.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "UiGradients",
                    description: "A handpicked collection of beautiful color gradients for designers and developers.",
                    link: "https://uigradients.com/",
                    user: user
                  )

resource.tag_list.add("colors")
resource.tag_list.add("front-end")
resource.tag_list.add("design")
resource.tag_list.add("style")
resource.tag_list.add("css")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423926/Le%20voyage/ui-gradients.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Adobe Color Wheel",
                    description: "Create color palettes with the color wheel or image, browse thousands of color combinations from the Adobe Color community.",
                    link: "https://color.adobe.com",
                    user: user
                  )

resource.tag_list.add("colors")
resource.tag_list.add("front-end")
resource.tag_list.add("design")
resource.tag_list.add("style")
resource.tag_list.add("css")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423926/Le%20voyage/adobe-color.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "ColorSlurp",
                    description: "ColorSlurp. Pick, edit, and copy colors with the best color picker for Mac!",
                    link: "https://colorslurp.com",
                    user: user
                  )

resource.tag_list.add("colors")
resource.tag_list.add("color-picker")
resource.tag_list.add("front-end")
resource.tag_list.add("design")
resource.tag_list.add("css")
resource.tag_list.add("style")
resource.tag_list.add("app")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423926/Le%20voyage/color-slurp.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "ColorZilla",
                    description: "Advanced Eyedropper, Color Picker, Gradient Generator and more.",
                    link: "https://www.colorzilla.com",
                    user: user
                  )

resource.tag_list.add("colors")
resource.tag_list.add("color-picker")
resource.tag_list.add("front-end")
resource.tag_list.add("design")
resource.tag_list.add("style")
resource.tag_list.add("css")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423927/Le%20voyage/color-zilla.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Google Fonts",
                    description: "Making the web more beautiful, fast, and open through great typography.",
                    link: "https://fonts.google.com",
                    user: user
                  )

resource.tag_list.add("fonts")
resource.tag_list.add("css")
resource.tag_list.add("front-end")
resource.tag_list.add("design")
resource.tag_list.add("style")


file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423927/Le%20voyage/google-fonts.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "FontPair",
                    description: "Font Pair helps designers pair Google Fonts together. Beautiful Google Font combinations and pairs.",
                    link: "https://www.fontpair.co",
                    user: user
                  )

resource.tag_list.add("fonts")
resource.tag_list.add("css")
resource.tag_list.add("front-end")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423928/Le%20voyage/font-pair.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "FontAwesome",
                    description: "The world's most popular and easiest to use icon set just got an upgrade. More icons. More styles. More Options.",
                    link: "https://fontawesome.com/",
                    user: user
                  )

resource.tag_list.add("fonts")
resource.tag_list.add("html")
resource.tag_list.add("design")
resource.tag_list.add("front-end")
resource.tag_list.add("style")
resource.tag_list.add("gem")


file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423927/Le%20voyage/font-awesome.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "IconFinder",
                    description: "Iconfinder is the leading search engine and market place for vector icons in SVG, PNG, CSH and AI format.",
                    link: "https://www.iconfinder.com",
                    user: user
                  )

resource.tag_list.add("icons")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423928/Le%20voyage/iconfinder.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Flat Icon",
                    description: "2699000+ Free vector icons in SVG, PSD, PNG, EPS format or as ICON FONT. Thousands of free icons in the largest database of free vector icons!",
                    link: "https://www.flaticon.com",
                    user: user
                  )

resource.tag_list.add("icons")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423928/Le%20voyage/flaticon.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Nucleo App",
                    description: "Nucleo is a beautiful library of 29280 icons, and a powerful application to collect, customize and export all your icons.",
                    link: "https://nucleoapp.com",
                    user: user
                  )

resource.tag_list.add("icons")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423928/Le%20voyage/nucleo.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Unsplash",
                    description: "Beautiful, free images and photos that you can download and use for any project. Better than any royalty free or stock photos.",
                    link: "https://unsplash.com",
                    user: user
                  )

resource.tag_list.add("images")
resource.tag_list.add("backgrounds")
resource.tag_list.add("royalty-free")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656424746/Le%20voyage/unsplash.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Pexels",
                    description: "Free stock photos you can use everywhere. ✓ Free for commercial use ✓ No attribution required.",
                    link: "https://www.pexels.com",
                    user: user
                  )

resource.tag_list.add("images")
resource.tag_list.add("backgrounds")
resource.tag_list.add("royalty-free")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423925/Le%20voyage/pexels.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Pixabay",
                    description: "Find your perfect free image or video to download and use for anything. ✓ Free for commercial use ✓ No attribution required ✓ High quality images.",
                    link: "https://pixabay.com",
                    user: user
                  )

resource.tag_list.add("images")
resource.tag_list.add("backgrounds")
resource.tag_list.add("royalty-free")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423926/Le%20voyage/pixabay.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "StockSnap",
                    description: "The #1 source for beautiful free photos. High quality and high resolution stock images free from all copyright restrictions (CC0) - no attribution required.",
                    link: "https://stocksnap.io",
                    user: user
                  )

resource.tag_list.add("images")
resource.tag_list.add("backgrounds")
resource.tag_list.add("royalty-free")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423925/Le%20voyage/stocksnap.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Gratisography",
                    description: "The world's quirkiest collection of free high-resolution pictures, comprised of the world's best, most creative images - photos you just won't find anywhere else.",
                    link: "https://gratisography.com",
                    user: user
                  )

resource.tag_list.add("images")
resource.tag_list.add("backgrounds")
resource.tag_list.add("royalty-free")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423926/Le%20voyage/gratisography.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "unDraw",
                    description: "The design project with open-source illustrations for any idea you can imagine and create.",
                    link: "https://undraw.co",
                    user: user
                  )

resource.tag_list.add("graphics")
resource.tag_list.add("icons")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656424925/Le%20voyage/undraw.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Glaze",
                    description: "Free illustrations, for everything. Memorable products, brands, & presentations start with our curated royalty-free illustration library.",
                    link: "https://www.glazestock.com/",
                    user: user
                  )

resource.tag_list.add("graphics")
resource.tag_list.add("icons")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656424926/Le%20voyage/glaze.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Dribbble",
                    description: "Dribbble is where designers gain inspiration, feedback, community, and jobs and is your best resource to discover and connect with designers worldwide.",
                    link: "https://dribbble.com/",
                    user: user
                  )

resource.tag_list.add("graphics")
resource.tag_list.add("websites")
resource.tag_list.add("inspiration")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423926/Le%20voyage/dribble.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Awwwards.",
                    description: "Awwwards are the Website Awards that recognize and promote the talent and effort of the best developers, designers and web agencies in the world.",
                    link: "https://www.awwwards.com/",
                    user: user
                  )

resource.tag_list.add("inspiration")
resource.tag_list.add("websites")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423926/Le%20voyage/awwwards.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Calltoidea",
                    description: "Calltoidea is the unique place where you can find inspiration. A great tool created by a designer for web professionals.",
                    link: "https://www.calltoidea.com/",
                    user: user
                  )

resource.tag_list.add("graphics")
resource.tag_list.add("websites")
resource.tag_list.add("inspiration")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423926/Le%20voyage/call-to-idea.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Collect UI",
                    description: "Daily inspiration collected from daily ui archive and beyond. Based on Dribbble shots, hand picked, updating daily.",
                    link: "https://collectui.com/",
                    user: user
                  )

resource.tag_list.add("graphics")
resource.tag_list.add("websites")
resource.tag_list.add("inspiration")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423927/Le%20voyage/collect-ui.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Lapa Ninja",
                    description: "The best landing page design inspiration from around the web. Lapa Ninja is created to help designers find inspiration, learn and improve design skills.",
                    link: "https://www.lapa.ninja",
                    user: user
                  )

resource.tag_list.add("graphics")
resource.tag_list.add("websites")
resource.tag_list.add("landing-pages")
resource.tag_list.add("inspiration")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423927/Le%20voyage/lapa.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Behance",
                    description: "Find curated interaction design work from cutting edge UI/UX design to detailed iconography.",
                    link: "https://www.behance.net/",
                    user: user
                  )

resource.tag_list.add("graphics")
resource.tag_list.add("websites")
resource.tag_list.add("inspiration")
resource.tag_list.add("front-end")
resource.tag_list.add("css")
resource.tag_list.add("design")
resource.tag_list.add("style")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423925/Le%20voyage/behance.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Ruby on Rails Guides",
                    description: "This guide will get you started with models, persistence to database, and the Active Record pattern and library. Active Record Migrations.",
                    link: "https://guides.rubyonrails.org/",
                    user: user
                  )

resource.tag_list.add("rails")
resource.tag_list.add("ruby")
resource.tag_list.add("html")
resource.tag_list.add("gem")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423925/Le%20voyage/rails.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Simple Form",
                    description: "Rails forms made easy. Simple Form aims to be as flexible as possible while helping you with powerful components to create your forms.",
                    link: "https://github.com/heartcombo/simple_form",
                    user: user
                  )

resource.tag_list.add("rails")
resource.tag_list.add("ruby")
resource.tag_list.add("html")
resource.tag_list.add("gem")
resource.tag_list.add("forms")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423925/Le%20voyage/simple-form.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "slick carousel",
                    description: "slick is a responsive carousel jQuery plugin that supports multiple breakpoints, CSS3 transitions, touch events/swiping & much more!",
                    link: "https://kenwheeler.github.io/slick/",
                    user: user
                  )

resource.tag_list.add("javascript")
resource.tag_list.add("jquery")
resource.tag_list.add("front-end")
resource.tag_list.add("carousel")
resource.tag_list.add("yarn")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423926/Le%20voyage/slick.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Flatpickr",
                    description: "flatpickr is a lightweight and powerful datetime picker. Lean, UX-driven, and extensible, yet it doesn't depend on any libraries.",
                    link: "https://flatpickr.js.org/",
                    user: user
                  )

resource.tag_list.add("javascript")
resource.tag_list.add("front-end")
resource.tag_list.add("calendar")
resource.tag_list.add("form")
resource.tag_list.add("yarn")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423926/Le%20voyage/flatpickr.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Stimulus",
                    description: "A modest JavaScript framework for the HTML you already have.",
                    link: "https://stimulus.hotwired.dev/",
                    user: user
                  )

resource.tag_list.add("javascript")
resource.tag_list.add("stimulus")
resource.tag_list.add("rails")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423926/Le%20voyage/stimulus.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "jQuery Star & Bar Rating",
                    description: "jQuery Bar Rating Plugin works by transforming a standard select field into a rating widget.",
                    link: "https://antennaio.github.io/jquery-bar-rating/",
                    user: user
                  )

resource.tag_list.add("javascript")
resource.tag_list.add("jquery")
resource.tag_list.add("front-end")
resource.tag_list.add("rating")
resource.tag_list.add("yarn")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423927/Le%20voyage/jquery-star-rating.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "noUiSlider",
                    description: "noUiSlider is a lightweight range slider with multi-touch support and a ton of features.",
                    link: "https://refreshless.com/nouislider/",
                    user: user
                  )

resource.tag_list.add("javascript")
resource.tag_list.add("front-end")
resource.tag_list.add("form")
resource.tag_list.add("slider")
resource.tag_list.add("yarn")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423927/Le%20voyage/no-ui-slider.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"


resource = Resource.new(
                    title: "Chart.js",
                    description: "Simple, clean and engaging HTML5 based JavaScript charts. Chart.js is an easy way to include animated, interactive graphs on your website for free.",
                    link: "https://www.chartjs.org/",
                    user: user
                  )

resource.tag_list.add("javascript")
resource.tag_list.add("front-end")
resource.tag_list.add("charts")
resource.tag_list.add("yarn")

file = URI.open("https://res.cloudinary.com/dxb6saco2/image/upload/v1656423927/Le%20voyage/chart-js.png")
resource.photo.attach(io: file, filename: "#{resource.title}.png", content_type: 'image/png')
resource.save!

puts "created the resource #{resource.title}"










