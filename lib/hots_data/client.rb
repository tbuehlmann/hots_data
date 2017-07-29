# frozen_string_literal: true

require_relative '../hots_data/authenticator'
require_relative '../hots_data/fetcher'
require_relative '../hots_data/repositories/replay_summary_repository'
require_relative '../hots_data/repositories/replay_repository'

module HotsData
  class Client
    attr_reader :token

    def initialize(token: nil, email: nil, password: nil)
      @token = if token
        token
      elsif email && password
        Authenticator.token_for(email: email, password: password)
      else
        raise 'Authentication needed. Either provide a token or email/password combination.'
      end
    end

    def replay_summaries
      Repositories::ReplaySummaryRepository.new(self)
    end

    def replays
      Repositories::ReplayRepository.new(self)
    end

    def fetcher
      @fetcher ||= Fetcher.new(token)
    end
  end
end
