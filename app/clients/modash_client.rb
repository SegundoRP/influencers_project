require 'uri'
require 'net/http'
require 'json'

class ModashClient
  MODASH_BASE_URL = 'https://influencer.free.beeceptor.com'
  MODASH_ACCESS_TOKEN = Rails.application.credentials.modash_access_token
  MAX_RETRIES = 3
  BASE_DELAY = 2.seconds

  def initialize(platform)
    @platform = platform
  end

  def fetch_influencers
    response = get_request("#{platform}/users?limit=10")

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      handle_api_error(response)
    end
  rescue JSON::ParserError => e
    Rails.logger.error("Failed to parse JSON response: #{e.message}")
    raise e
  end

  private

  attr_reader :platform

  def build_url(path)
    URI("#{MODASH_BASE_URL}/#{path}")
  end

  def request_with_headers(request)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{MODASH_ACCESS_TOKEN}"
    request
  end

  def get_request(path)
    request_url = build_url(path)
    request = Net::HTTP::Get.new(request_url)
    request = request_with_headers(request)

    Net::HTTP.start(request_url.host, request_url.port, use_ssl: request_url.scheme == "https") do |http|
      http.request(request)
    end
  end

  def retry_request(retries)
    retries += 1
    if retries <= MAX_RETRIES
      sleep(BASE_DELAY * (2 ** retries))
      fetch_influencers
    else
      raise "Too many retries for platform #{platform}: #{e.message}"
    end
  end

  def handle_api_error(response)
    error_data = JSON.parse(response.body)
    error_code = error_data["code"]
    error_message = error_data["message"]

    case error_code
    when "retry_later", "request_timeout"
      retries = 0
      retry_request(retries)
      raise RetryableError, error_message
    when "api_token_invalid", "not_enough_credits", "internal_server_error"
      raise CriticalError, error_message
    when "handle_not_found", "account_not_found", "media_not_found", "entity_not_found", "private_account", "empty_audience"
      raise NotFoundError, error_message
    else
      raise StandardError, "API error: #{error_message}"
    end
  end
end

class RetryableError < StandardError; end
class CriticalError < StandardError; end
class NotFoundError < StandardError; end
