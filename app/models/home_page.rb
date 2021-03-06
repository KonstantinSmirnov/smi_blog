class HomePage
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Alize
  extend Dragonfly::Model
  extend Dragonfly::Model::Validations

  dragonfly_accessor :title_backgroung
  field :title_backgroung_uid, type: String
  field :title_backgroung_name, type: String

  field :video_url, type: String

  # SECTION 1 (Title)
  field :title, type: String
  validates :title,
            presence: true
  field :subtitle, type: String
  validates_property :format, of: :title_backgroung, in: ['jpeg', 'png', 'gif'],
                      message: "the formats allowed are: .jpeg, .png, .gif", if: :title_backgroung_changed?

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
