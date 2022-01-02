require "dadata_metro/constants"
require 'json'
require 'net/http'

module DadataMetro
  class Search

    attr_reader :api_token

    def initialize(api_token:)
      @api_token = api_token
    end

    def call(query:, filters: nil)
      check_api_token
      check_query(query)
      check_filters(filters)

      JSON.parse(request(query, filters))
    end

    private

    def url
      URI(Constants::BASE_URL)
    end

    def request(query, filters)
      req = Net::HTTP::Post.new(url)

      req['Content-Type'] = 'application/json'
      req['Accept'] = 'application/json'
      req['Authorization'] = "Token #{api_token}"

      req.body = { query: query, filters: filters }.to_json

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.request(req).body.force_encoding('UTF-8')
    end

    def check_query(query)
      raise ArgumentError, 'query is required' unless query
      raise ArgumentError, 'query is too long' if query.length > Constants::QUERY_MAX_LENGTH
    end

    def check_filters(filters)
      return unless filters
      raise ArgumentError, 'filters should be array' unless filters.is_a?(Array)
      filters.each do |field|
        key = field.keys.first
        next if Constants::FILTERS_FIELDS.include? key
        raise ArgumentError, "filter field #{key} not supported"
      end
    end

    def check_api_token
      raise ArgumentError, 'api_token is required' unless api_token
    end
  end
end
