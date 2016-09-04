class Social
  include Mongoid::Document
  field :icon_text, type: String
  field :link, type: String

  validates :icon_text, :link, length: { minimum: 1 }

end
