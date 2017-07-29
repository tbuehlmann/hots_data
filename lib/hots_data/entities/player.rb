# frozen_string_literal: true

require_relative '../../hots_data/entity'

module HotsData
  module Entities
    class Player < Entity
      attribute :id
      attribute :hero
      attribute :name
      attribute :rank
      attribute :team
      attribute :realm
      attribute :region
      attribute :slot_id
      attribute :human
      attribute :player_id
      attribute :battle_tag
      attribute :hero_level
      attribute :game_result
      attribute :toon_handle
    end
  end
end
