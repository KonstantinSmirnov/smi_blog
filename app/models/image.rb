class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Alize
  extend Dragonfly::Model
  extend Dragonfly::Model::Validations

  dragonfly_accessor :image
  field :image_uid, type: String
  field :image_name, type: String
  
  field :description, type: String
  field :article_id, type: Integer
  field :primary_image, type: Boolean, default: false


  validates :description, :image, :article_id,
            presence: true
  validates_property :format, of: :image, in: ['jpeg', 'png', 'gif'],
                      message: "the formats allowed are: .jpeg, .png, .gif", if: :image_changed?

  belongs_to :article
  alize :article, :title

  scope :primary_images, -> { where(primary_image: 'true') }
end
