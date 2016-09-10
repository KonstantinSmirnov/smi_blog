class About
  include Mongoid::Document
  include Mongoid::Paperclip

  field :top_block_content, type: String
  has_mongoid_attached_file :about_foto,
    :styles => {
    :original => ['1920x1680>', :jpg],
    :preview  => ['100x100>',   :jpg]
  }

  validates :top_block_content, length: { minimum: 1 }
  validates_attachment_content_type :about_foto, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)'

end
