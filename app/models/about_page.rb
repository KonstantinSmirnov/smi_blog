class AboutPage
  include Mongoid::Document
  include Mongoid::Paperclip

  field :content, type: String
  has_mongoid_attached_file :about_foto,
    :styles => {
    :original => ['1000>', :jpg],
    :preview  => ['100x100>',   :jpg]
  },
    :url => '/system/:class/:attachment/:style/:filename'

  validates :content, :about_foto, presence: true
  validates_attachment_content_type :about_foto, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)'

end
