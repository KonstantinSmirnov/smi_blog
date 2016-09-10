class About
  include Mongoid::Document
  field :top_block_content, type: String

  validates :top_block_content, length: { minimum: 1 }

end
