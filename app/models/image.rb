class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Alize


  field :description, type: String
  field :article_id, type: Integer
  field :primary_image, type: Boolean, default: false
  has_mongoid_attached_file :image,
    :source_file_options => { all: '-background transparent' },
    :styles => {
    :original => ['1000>'],
    :preview  => ['600x600>'],
    :thumbnail => ['100x100>']
    },
    :url => '/system/:class/:attachment/:style/:hash.:extension',
    :hash_secret => "secret"
  validates :description, :image, :article_id,
            presence: true
  validates_attachment_content_type :image,
            :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/,
            :message => 'file type is not allowed (only jpeg/png/gif images)'

  belongs_to :article
  alize :article, :title

  scope :primary_images, -> { where(primary_image: 'true') }
end
