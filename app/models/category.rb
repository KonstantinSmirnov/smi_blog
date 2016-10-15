class Category
  include Mongoid::Document
  include Mongoid::Alize

  field :slug, type: String
  field :name, type: String

  validates :slug, :name, presence: true
  validates :slug, :name, uniqueness: true

  has_many :articles

  alize :articles, :title

  index slug: 1

  def to_param
    slug
  end

  before_validation do
    self.slug = Translit.convert(self.name, :english)
    self.slug = self.slug.downcase.gsub(/[^0-9a-z]/i, '-')
  end
end
