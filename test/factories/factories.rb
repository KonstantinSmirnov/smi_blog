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
end
