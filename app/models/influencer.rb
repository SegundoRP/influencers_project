class Influencer < ApplicationRecord
  validates :username, uniqueness: { scope: :platform }
  validates :external_id, uniqueness: { scope: :platform }, allow_nil: true
  validates :username, :fullname, :picture, :followers, :platform, presence: true
  validates :is_verified, inclusion: { in: [true, false] }

  enum :platform, { youtube: 0, instagram: 1, tiktok: 2 }
end
