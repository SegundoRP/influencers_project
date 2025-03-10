module InfluencerHelper
  def influencer_is_verified(influencer)
    influencer.is_verified ? "check.png" : "mark.png"
  end
end
