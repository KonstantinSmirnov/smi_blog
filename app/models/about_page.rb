class AboutPage
  include Mongoid::Document
  include Mongoid::Timestamps
  extend Dragonfly::Model
  extend Dragonfly::Model::Validations

  dragonfly_accessor :image
  field :image_uid, type: String
  field :image_name, type: String

  field :content, type: String

  validates :content, :image, presence: true

  validates_property :format, of: :image, in: ['jpeg', 'png', 'gif'],
                      message: "the formats allowed are: .jpeg, .png, .gif", if: :image_changed?

end
