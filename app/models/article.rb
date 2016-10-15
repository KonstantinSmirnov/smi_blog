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

  def self.random(n = 1)
    result = (0..Article.published.count-1).sort_by{rand}.slice(0, n).collect! do |i| Article.published.skip(i).first end
  end

  def update_publication_date
    if self.published?
      self.published_on = DateTime.now if self.published_on == nil
      self.save!
    elsif self.draft?
      self.published_on = nil
      self.save!
    end
  end

  before_validation do
    self.slug = Translit.convert(self.slug, :english)
    self.slug = self.slug.downcase.gsub(/[^0-9a-z]/i, '-')
  end
end
