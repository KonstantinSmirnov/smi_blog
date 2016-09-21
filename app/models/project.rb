class Project
  include Mongoid::Document
  extend Dragonfly::Model

  dragonfly_accessor :image
  field :image_uid, type: String
  field :image_name, type: String
  field :title, type: String

  validates :title, :image, presence: true

  belongs_to :home_page
end
