class Category
  include Mongoid::Document
  include Mongoid::Alize
  
  field :name, type: String

  validates :name, length: { minimum: 1 }
  
  has_many :articles

end
