class Article
  include Mongoid::Document
  field :title, type: String
  field :description, type: String

  validates :title, :description, length: { minimum: 1 }

end
