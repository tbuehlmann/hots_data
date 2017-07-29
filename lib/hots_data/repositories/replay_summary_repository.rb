# frozen_string_literal: true

require_relative '../../hots_data/entities/replay_summary'

module HotsData
  module Repositories
    class ReplaySummaryRepository
      include Enumerable

      attr_accessor :page_value

      def initialize(client)
        @client = client
        @loaded = false
        @page_value = nil
      end

      def each(&block)
        load unless loaded?
        replay_summaries.each(&block)
      end

      def lazy
        Enumerator.new do |yielder|
          1.upto(Float::INFINITY) do |page|
            replay_summaries = replay_summaries_for_page(page)

            replay_summaries.each do |replay_summary|
              yielder << replay_summary
            end

            break if replay_summaries.size < 50
          end
        end
      end

      def size
        to_a.size
      end

      alias_method :length, :size

      def last
        to_a.last
      end

      def [](index)
        first(index + 1).last
      end

      def page(page)
        clone.tap do |repository|
          unload
          repository.page_value = Integer(page)
        end
      end

      def replay_summaries
        @replay_summaries ||= []
      end

      private

      attr_reader :client

      def load
        if page_value
          replay_summaries.concat(replay_summaries_for_page(page_value))
        else
          replay_summaries.concat(lazy.to_a)
        end

        @loaded = true
      end

      def unload
        replay_summaries.clear
        @loaded = false
      end

      def loaded?
        @loaded
      end

      def replay_summaries_for_page(page)
        client.fetcher.fetch('list', params: {page: page})['data'].map do |json_attributes|
          attributes = attributes_from_json(json_attributes)

          Entities::ReplaySummary.new(attributes).tap do |replay_summary|
            replay_summary.client = client
          end
        end
      end

      def attributes_from_json(json_attributes)
        {}.tap do |attributes|
          attributes[:map_name] = json_attributes['mapname']
          attributes[:duration] = json_attributes['duration']
          attributes[:game_type] = json_attributes['gametype']
          attributes[:uploaded_at] = Time.strptime(json_attributes['uploaded_at'], '%m/%d/%Y %H:%M:%S')
          attributes[:played_at] = Time.strptime(json_attributes['played_at'], '%m/%d/%Y %H:%M:%S')
          attributes[:replay_id] = json_attributes['replayid']
          attributes[:player] = json_attributes['players']
          attributes[:hero_name] = json_attributes['heroname']
          attributes[:hero_level] = json_attributes['herolevel'].to_i
          attributes[:match_result] = json_attributes['matchresult']
        end
      end
    end
  end
end
