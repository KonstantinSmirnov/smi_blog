class Project
  include Mongoid::Document
  extend Dragonfly::Model
  extend Dragonfly::Model::Validations

  dragonfly_accessor :image
  field :image_uid, type: String
  field :image_name, type: String
  field :title, type: String

  validates :title, :image, presence: true
  validates_property :format, of: :image, in: ['jpeg', 'png', 'gif'],
                      message: "the formats allowed are: .jpeg, .png, .gif", if: :image_changed?

  belongs_to :home_page
end
