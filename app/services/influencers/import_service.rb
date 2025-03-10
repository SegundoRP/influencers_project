class Influencers::ImportService
  def initialize(influencers_data, platform)
    @influencers_data = influencers_data
    @platform = platform
  end

  def call
    Influencer.upsert_all(
      build_influencers_data(influencers_data), unique_by: %i[external_id platform]
    )
  end

  private

  attr_reader :influencers_data, :platform

  def build_influencers_data(influencers_data)
    influencers_data.map do |influencer|
      influencer.with_indifferent_access.slice(
        :username, :fullname, :picture, :followers
      ).merge(
        is_manual: false, platform: platform, is_verified: influencer["isVerified"], external_id: influencer["userId"]
      )
    end
  end
end
