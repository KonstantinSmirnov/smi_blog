class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum

  field :title, type: String
  field :description, type: String
  field :content, type: String
  field :published_at, type: Date
  field :views, type: Integer, default: 0
  
  enum :status, [:draft, :published], default: :draft

  validates :title, :description, :content, length: { minimum: 1 }

end
