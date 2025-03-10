class ImportInfluencersJob < ApplicationJob
  queue_as :default
  PLATFORMS = Influencer.platforms.keys.freeze

  retry_on Net::OpenTimeout, Timeout::Error, wait: :exponentially_longer, attempts: 3

  def perform
    PLATFORMS.each do |platform|
      begin
        influencers_data = modash_client(platform).fetch_influencers["users"]

        next if influencers_data.blank?

        Influencers::ImportService.new(influencers_data, platform).call
      rescue StandardError => e
        Rails.logger.error("Failed to import influencers for platform #{platform}: #{e.message}")
        raise e
      end
    end

    broadcast_influencers
  end

  private

  def modash_client(platform)
    @modash_client ||= ModashClient.new(platform)
  end

  def broadcast_influencers
    Turbo::StreamsChannel.broadcast_replace_to "influencers_list",
                        partial: "influencers/list",
                        target: "influencers",
                        locals: { influencers: Influencer.all }
  end
end
