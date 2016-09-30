class Article
  require 'translit'

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum
  include Mongoid::Alize
  include Mongoid::Search

  field :slug, type: String
  field :title, type: String
  field :description, type: String
  field :keywords, type: String
  field :content, type: String
  field :published_on, type: DateTime
  field :views, type: Integer, default: 0
  field :category_id, type: Integer

  enum :status, [:draft, :published], default: :draft

  validates :slug, :title, :description, :keywords, :content, presence: true
  validates :slug, uniqueness: true

  belongs_to :category
  alize :category, :name

  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images, :allow_destroy => true

  has_and_belongs_to_many :tags
  alize :tags, :name

  accepts_nested_attributes_for :tags, :allow_destroy => true

  index slug: 1

  search_in :title, :description, :content

  def to_param
    slug
  end

end
