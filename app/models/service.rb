class Service
  include Mongoid::Document

  field :icon, type: String
  field :title, type: String
  field :content, type: String
  validates :icon, :title, :content, presence: true

  belongs_to :home_page, :inverse_of => :services

end
