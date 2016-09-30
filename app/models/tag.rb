class Tag
  require 'translit'

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Alize

  field :slug, type: String
  field :name, type: String

  validates :name, :slug, length: { minimum: 1 }
  
  has_and_belongs_to_many :articles
  
  alize :articles, :title
  
  index slug: 1
  
  def to_param
    slug
  end
  
  before_validation do
    if !self.slug
      self.slug = Translit.convert(self.name, :english).downcase.gsub(/[^0-9a-z]/i, '-')
    end
  end

end