# frozen_string_literal: true

require_relative '../../hots_data/entity'

module HotsData
  module Entities
    class Replay < Entity
      attribute :event
      attribute :speed
      attribute :stage
      attribute :team_1
      attribute :team_2
      attribute :map_name
      attribute :map_size
      attribute :game_type
      attribute :game_loops
      attribute :start_time
      attribute :replay_path
      attribute :game_version

      attribute :players
      attribute :player_stats
    end
  end
end
