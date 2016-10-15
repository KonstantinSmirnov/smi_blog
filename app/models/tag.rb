class Tag
  require 'translit'

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Alize

  field :slug, type: String
  field :name, type: String
  field :articles_count, type: Integer, default: 1

  validates :name, presence: true
  validates :name, :slug, uniqueness: true

  has_and_belongs_to_many :articles

  index slug: 1

  def to_param
    slug
  end

  before_validation do
    self.slug = Translit.convert(self.name, :english).downcase.gsub(/[^0-9a-z]/i, '-')
    update_articles_count
  end

  def update_articles_count
    self.articles_count = self.articles ? self.articles.count : 0
  end

end
