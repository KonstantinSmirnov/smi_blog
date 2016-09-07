class Category
  include Mongoid::Document
  field :name, type: String

  validates :name, length: { minimum: 1 }

end
