class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :description, type: String
  has_mongoid_attached_file :image,
    :styles => {
    :original => ['1000>', :jpg],
    :preview  => ['100x100>',   :jpg]
  }
  validates :description,
            presence: true
  validates_attachment_content_type :image,
            :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/,
            :message => 'file type is not allowed (only jpeg/png/gif images)'

  belongs_to :article

end
