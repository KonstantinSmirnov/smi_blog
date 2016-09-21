class HomePage
  include Mongoid::Document
  include Mongoid::Alize
  extend Dragonfly::Model

  dragonfly_accessor :title_backgroung
  field :title_backgroung_uid, type: String
  field :title_backgroung_name, type: String

  # SECTION 1 (Title)
  field :title, type: String
  validates :title,
            presence: true

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
