# frozen_string_literal: true

require_relative '../../hots_data/entity'
require_relative '../../hots_data/repositories/replay_repository'

module HotsData
  module Entities
    class ReplaySummary < Entity
      attribute :map_name
      attribute :duration
      attribute :game_type
      attribute :uploaded_at
      attribute :played_at
      attribute :replay_id
      attribute :player
      attribute :hero_name
      attribute :hero_level
      attribute :match_result

      def replay
        Repositories::ReplayRepository.new(client).find(replay_id)
      end
    end
  end
end
