class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum
  include Mongoid::Alize

  field :title, type: String
  field :description, type: String
  field :content, type: String
  field :published_on, type: DateTime
  field :views, type: Integer, default: 0
  field :category_id, type: Integer

  enum :status, [:draft, :published], default: :draft

  validates :title, :description, :content, length: { minimum: 1 }

  belongs_to :category
  alize :category, :name

  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true
end
