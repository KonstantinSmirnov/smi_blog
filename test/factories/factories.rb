FactoryGirl.define do
  factory :category do
    name "Test Category"
  end

  factory :article do
    slug "this-is-a-slug"
    title "this is a title"
    description "this is a description"
    keywords "there are keywords"
    content "this is a content"
    category
    published_on nil
  end

  factory :comment do
    article
    author_name "test author"
    text "there is some text"
  end

  factory :social do
    icon_text "facebook"
    link "http://mail.ru"
  end

  factory :about_page do
    image_uid "this is image_uid"
    image_name "this is image name"
    content "There is a little of content"
  end

  factory :home_page do
    title_backgroung_uid "this is image uid"
    title_backgroung_name "this is image name"
    title "there is a title"

    about_title "this is about_title"
    about_content "this is about content"

    services_title "this is services title"
    #embeded services

    projects_title "this is projects_title"
  end

  factory :image do
    image_uid "there is image uid"
    image_name "there is image name"
    description "there is image description"
  end

  factory :project do
    image_uid "there is image uid"
    image_name "there is image name"
    title "there is a title"
  end

  factory :service do
    icon "there is an icon"
    title "there is a title"
    content "there is a content"
  end

  factory :setting do
    website_title "there is a website title"
    default_description "there is a default description"
    default_keywords "there are default keywords"
    twitter_share_via_account "there is a default twitter account"
  end

  factory :tag do
    slug "there is a slug"
    name "there is a name"
    
  end
end
