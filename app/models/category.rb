class Category
  include Mongoid::Document
  include Mongoid::Alize

  field :name, type: String

  validates :name, length: { minimum: 1 }, uniqueness: true

  has_many :articles
  
  alize :articles, :title

end
