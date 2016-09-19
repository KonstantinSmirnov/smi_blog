class Setting
  include Mongoid::Document
  include Mongoid::Paperclip

  field :default_description, type: String
  field :default_keywords, type: String

  validates :default_description, :default_keywords, presence: true

end
