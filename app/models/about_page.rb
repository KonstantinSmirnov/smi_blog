class AboutPage
  include Mongoid::Document
  extend Dragonfly::Model

  dragonfly_accessor :image
  field :image_uid, type: String
  field :image_name, type: String

  field :content, type: String

  validates :content, :image, presence: true

end
