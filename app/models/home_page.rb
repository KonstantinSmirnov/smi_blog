class HomePage
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Alize

  # SECTION 1 (Title)
  field :title, type: String
  has_mongoid_attached_file :title_backgroung,
    :styles => {
    :original => ['1000>', :jpg],
    :preview  => ['100x100>',   :jpg]
  },
    :url => '/system/:class/:attachment/:style/:filename'
  validates :title,
            presence: true
  validates_attachment_content_type :title_backgroung,
            :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/,
            :message => 'file type is not allowed (only jpeg/png/gif images)'

  # SECTION 2 (About)
  field :about_title, type: String
  field :about_content, type: String
  validates :about_title,
            :about_content,
            presence: true
  # SECTION 3 (Services)
  field :services_title, type: String
  validates :services_title,
            presence: true
  embeds_many :services
  accepts_nested_attributes_for :services, :allow_destroy => true

  
  # SECTION 4 (Last projects)
  field :projects_title, type: String
  validates :projects_title,
            presence: true
  has_many :projects

end
