class Project
  include Mongoid::Document
  include Mongoid::Paperclip

  field :title, type: String
  has_mongoid_attached_file :image,
    :styles => {
    :original => ['450x450#', :jpg],
    :preview  => ['100x100#',   :jpg]
  }
  
  validates :title, presence: true
  validates_attachment_content_type :image,
            :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/,
            :message => 'file type is not allowed (only jpeg/png/gif images)'
            
  belongs_to :home_page
end
