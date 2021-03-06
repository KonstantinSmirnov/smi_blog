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

default_category = Category.new
default_category.name = "(no category)"
default_category.save!

home_page = HomePage.new
home_page.title = 'Hello world!'
home_page.video_url = 'https://www.youtube.com/watch?v=y0sl4fIxm4E&list=PLQhyATD_4rfdBMstiIs7SvxtVAAJj24dN&index=17'
home_page.about_title = 'About'
home_page.subtitle = 'Interesting information about your favorite framework and many more useful articles here! '
home_page.about_content = 'Donec sed odio dui. Cras mattis consectetur purus sit amet fermentum. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Etiam porta sem malesuada magna mollis euismod. Nulla vitae elit libero, a pharetra augue.'
home_page.services_title = 'Services'
home_page.services.build(
    icon: 'pencil',
    title: 'Design',
    content: 'Every website is beautiful, unique and tailored to suit your needs and requirements.')
home_page.services.build(
    icon: 'laptop',
    title: 'Development',
    content: 'All websites are written in valid and clean HTML5 / CSS3 & JavaScript (jQuery).')
home_page.services.build(
    icon: 'tablet',
    title: 'Support',
    content: 'All websites are responsive. They will look great on desktop, tablets and mobile phones too.')
home_page.projects_title = 'Projects'
home_page.save!

social_button = Social.new
social_button.icon_text = 'facebook'
social_button.link = 'http://facebook.com'
social_button.save!

settings = Setting.new
settings.website_title = 'TestPage'
settings.default_description = 'This is a default description for all pages which have not their own description.'
settings.default_keywords = 'There, are, default, keywords, on, all, pages, if, they, have, not, their, own, keywords'
settings.twitter_share_via_account = 'test'
settings.save!
