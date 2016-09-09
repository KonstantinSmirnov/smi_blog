class Tag
  include Mongoid::Document

  field :name, type: String

  validates :name, length: { minimum: 1 }, uniqueness: true

end