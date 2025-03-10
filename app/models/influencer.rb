class Influencer < ApplicationRecord
  validates :username, uniqueness: { scope: :platform }
  validates :external_id, uniqueness: { scope: :platform }, allow_nil: true
  validates :username, :fullname, :picture, :followers, :platform, presence: true
  validates :is_verified, inclusion: { in: [true, false] }
  validates :picture, format: { with: Rack::Utils::URI_PARSER.make_regexp }
  validates :followers, numericality: { only_integer: true }

  enum :platform, { youtube: 0, instagram: 1, tiktok: 2 }
end
