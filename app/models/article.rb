class Article
  require 'translit'

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum
  include Mongoid::Alize

  field :slug, type: String
  field :title, type: String
  field :description, type: String
  field :content, type: String
  field :published_on, type: DateTime
  field :views, type: Integer, default: 0
  field :category_id, type: Integer

  enum :status, [:draft, :published], default: :draft

  validates :slug, :title, :description, :content, presence: true
  validates :slug, uniqueness: true

  belongs_to :category
  alize :category, :name

  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true

  def to_param
    slug
  end

  before_save do
    self.slug = Translit.convert(self.slug, :english)
    self.slug = self.slug.downcase.gsub(/[^0-9a-z]/i, '-')
  end

  #   require 'translit'
  #
  # str = "Кириллица"
  # Translit.convert(str, :english)

end
