class HomePage
  include Mongoid::Document
  include Mongoid::Paperclip

  field :title, type: String
  has_mongoid_attached_file :title_background,
    :styles => {
    :original => ['1000>', :jpg],
    :preview  => ['100x100>',   :jpg]
  }

  validates :title, length: { minimum: 1 }
  validates_attachment_content_type :title_background, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)'

end
