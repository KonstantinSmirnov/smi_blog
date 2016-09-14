class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum

  field :article_id
  field :author_name, type: String
  field :text, type: String

  enum :status, [:fresh, :moderated, :banned], default: :fresh

  validates :author_name, length: { minimum: 1, maximum: 20 }
  validates :text, length: { minimum: 10, maximum: 140 }

  belongs_to :article

end
