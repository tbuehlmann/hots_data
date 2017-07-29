# frozen_string_literal: true

require 'http'

module HotsData
  class Authenticator
    def self.token_for(email:, password:)
      new(email: email, password: password).token
    end

    attr_reader :email, :password

    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def token
      @token ||= begin
        response = HTTP.post('http://api.hotsdata.com/login', json: {email: email, password: password})

        if response.status.ok? && token = response.parse['token']
          token
        else
          raise 'Could not authenticate with email and password.'
        end
      end
    end
  end
end
