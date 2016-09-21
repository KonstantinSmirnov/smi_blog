class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Alize
  extend Dragonfly::Model

  dragonfly_accessor :image
  field :image_uid, type: String
  field :image_name, type: String
  
  field :description, type: String
  field :article_id, type: Integer
  field :primary_image, type: Boolean, default: false


  validates :description, :image, :article_id,
            presence: true

  belongs_to :article
  alize :article, :title

  scope :primary_images, -> { where(primary_image: 'true') }
end
