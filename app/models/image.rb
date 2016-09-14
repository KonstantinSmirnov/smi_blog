class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Alize

  field :description, type: String
  field :article_id, type: Integer
  has_mongoid_attached_file :image,
    :styles => {
    :original => ['1000>', :jpg],
    :preview  => ['100x100>',   :jpg]
  }
  validates :description, :image, :article_id,
            presence: true
  validates_attachment_content_type :image,
            :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/,
            :message => 'file type is not allowed (only jpeg/png/gif images)'

  belongs_to :article
  alize :article, :title
end
