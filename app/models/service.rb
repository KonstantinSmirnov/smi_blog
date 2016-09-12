class Service
  include Mongoid::Document

  field :icon, type: String
  field :title, type: String
  field :content, type: String
  validates :icon, :title, :content, presence: true

  embedded_in :home_page, :inverse_of => :services

end
