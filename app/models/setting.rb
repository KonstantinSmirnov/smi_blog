class Setting
  include Mongoid::Document

  field :website_title, type: String
  field :default_description, type: String
  field :default_keywords, type: String
  field :twitter_share_via_account, type: String

  validates :website_title,
            :default_description,
            :default_keywords,
            :twitter_share_via_account,
            presence: true

end
