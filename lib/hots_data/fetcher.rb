# frozen_string_literal: true

require 'http'

module HotsData
  class Fetcher
    attr_reader :token, :last_response

    def initialize(token)
      @token = token
    end

    def fetch(path, params: {})
      response = http.get("#{base_url}/#{path}", params: params)
      handle_response(response)
    end

    private

    def http
      HTTP.auth("Bearer #{token}")
    end

    def handle_response(response)
      @last_response = response

      if response.status.ok?
        response.parse
      else
        raise "Something went wrong. #{response.status}: #{response}"
      end
    end

    def base_url
      'http://api.hotsdata.com'
    end
  end
end
