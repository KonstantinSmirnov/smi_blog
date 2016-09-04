# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = Admin.new
user.email = 'test@test.com'
#user.encrypted_password = '123123'
user.password = '123123'
user.password_confirmation = '123123'
user.save!

article1 = Article.new
article1.title = "tehre is a title"
article1.description = "there is a short description"
article1.save!

facebook_icon = Social.new
facebook_icon.icon_text = 'social-facebook'
facebook_icon.link = 'http://facebook.com'
facebook_icon.save!
