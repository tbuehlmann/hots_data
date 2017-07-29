# frozen_string_literal: true

require_relative '../../hots_data/entities/replay'
require_relative '../../hots_data/entities/player'
require_relative '../../hots_data/entities/player_stats'

module HotsData
  module Repositories
    class ReplayRepository
      def initialize(client)
        @client = client
      end

      def find(id)
        attributes = attributes_from_json(client.fetcher.fetch("replays/#{id}")[0])
        Entities::Replay.new(attributes)
      end

      private

      attr_reader :client

      def attributes_from_json(json_attributes)
        {}.tap do |attributes|
          attributes[:event] = json_attributes['replay_data']['event']
          attributes[:speed] = json_attributes['replay_data']['speed']
          attributes[:stage] = json_attributes['replay_data']['stage']
          attributes[:team_1] = json_attributes['replay_data']['team1']
          attributes[:team_2] = json_attributes['replay_data']['team2']
          attributes[:map_name] = json_attributes['replay_data']['mapName']
          attributes[:map_size] = json_attributes['replay_data']['mapSize']
          attributes[:game_type] = json_attributes['replay_data']['gameType']
          attributes[:game_loops] = json_attributes['replay_data']['gameLoops']
          attributes[:start_time] = Time.parse(json_attributes['replay_data']['startTime'])
          attributes[:replay_path] = json_attributes['replay_data']['replayPath']
          attributes[:game_version] = json_attributes['replay_data']['gameVersion']

          attributes[:players] = json_attributes['account_info'].map do |player_json_attributes|
            player_attributes = player_attributes_for(player_json_attributes)
            Entities::Player.new(player_attributes)
          end

          attributes[:player_stats] = json_attributes['player_stats'].map do |player_stats_json_attributes|
            player_stats_attributes = player_stats_attributes_for(player_stats_json_attributes)
            Entities::PlayerStats.new(player_stats_attributes)
          end
        end
      end

      def player_attributes_for(player_json_attributes)
        {}.tap do |player_attributes|
          player_attributes[:id] = player_json_attributes['id']
          player_attributes[:hero] = player_json_attributes['hero']
          player_attributes[:name] = player_json_attributes['name']
          player_attributes[:rank] = player_json_attributes['rank']
          player_attributes[:team] = player_json_attributes['team']
          player_attributes[:realm] = player_json_attributes['realm']
          player_attributes[:region] = player_json_attributes['region']
          player_attributes[:slot_id] = player_json_attributes['slotId']
          player_attributes[:human] = player_json_attributes['isHuman']
          player_attributes[:player_id] = player_json_attributes['playerId']
          player_attributes[:battle_tag] = player_json_attributes['battleTag']
          player_attributes[:hero_level] = player_json_attributes['heroLevel']
          player_attributes[:game_result] = player_json_attributes['gameResult']
          player_attributes[:toon_handle] = player_json_attributes['toonHandle']
        end
      end

      def player_stats_attributes_for(player_stats_json_attributes)
        {}.tap do |player_stats_attributes|
          player_stats_attributes[:id] = player_stats_json_attributes['id']
          player_stats_attributes[:role] = player_stats_json_attributes['Role']
          player_stats_attributes[:team] = player_stats_json_attributes['team']
          player_stats_attributes[:level] = player_stats_json_attributes['Level']

          player_stats_attributes[:deaths] = player_stats_json_attributes['deaths'].map do |death|
            {
              'x' => death['x'],
              'y' => death['y'],
              'id' => death['id'],
              'team' => death['team'],
              'victim' => death['victim'],
              'killers' => death['killers'],
              'seconds' => death['seconds'],
              'solo_death' => death['soloDeath']
            }
          end

          player_stats_attributes[:deaths_count] = player_stats_json_attributes['Deaths']
          player_stats_attributes[:assists] = player_stats_json_attributes['Assists']
          player_stats_attributes[:healing] = player_stats_json_attributes['Healing']
          player_stats_attributes[:solo_kill] = player_stats_json_attributes['SoloKill']
          player_stats_attributes[:wins_male] = player_stats_json_attributes['WinsMale']
          player_stats_attributes[:hero_name] = player_stats_json_attributes['heroName']
          player_stats_attributes[:player_id] = player_stats_json_attributes['playerId']
          player_stats_attributes[:replay_id] = player_stats_json_attributes['replayId']
          player_stats_attributes[:game_score] = player_stats_json_attributes['GameScore']
          player_stats_attributes[:plays_male] = player_stats_json_attributes['PlaysMale']
          player_stats_attributes[:takedowns] = player_stats_json_attributes['Takedowns']
          player_stats_attributes[:team_level] = player_stats_json_attributes['TeamLevel']
          player_stats_attributes[:town_kills] = player_stats_json_attributes['TownKills']
          player_stats_attributes[:kill_count] = player_stats_json_attributes['killCount']
          player_stats_attributes[:hero_damage] = player_stats_json_attributes['HeroDamage']
          player_stats_attributes[:wins_diablo] = player_stats_json_attributes['WinsDiablo']
          player_stats_attributes[:wins_female] = player_stats_json_attributes['WinsFemale']
          player_stats_attributes[:death_count] = player_stats_json_attributes['deathCount']
          player_stats_attributes[:creep_damage] = player_stats_json_attributes['CreepDamage']
          player_stats_attributes[:damage_taken] = player_stats_json_attributes['DamageTaken']
          player_stats_attributes[:plays_diablo] = player_stats_json_attributes['PlaysDiablo']
          player_stats_attributes[:plays_female] = player_stats_json_attributes['PlaysFemale']
          player_stats_attributes[:self_healing] = player_stats_json_attributes['SelfHealing']
          player_stats_attributes[:siege_damage] = player_stats_json_attributes['SiegeDamage']
          player_stats_attributes[:wins_support] = player_stats_json_attributes['WinsSupport']
          player_stats_attributes[:wins_warrior] = player_stats_json_attributes['WinsWarrior']
          player_stats_attributes[:level_events] = player_stats_json_attributes['levelEvents']
          player_stats_attributes[:seconds_dead] = player_stats_json_attributes['secondsDead']
          player_stats_attributes[:total_out_dmg] = player_stats_json_attributes['totalOutDmg']
          player_stats_attributes[:minion_damage] = player_stats_json_attributes['MinionDamage']
          player_stats_attributes[:plays_support] = player_stats_json_attributes['PlaysSupport']
          player_stats_attributes[:plays_warrior] = player_stats_json_attributes['PlaysWarrior']
          player_stats_attributes[:summon_damage] = player_stats_json_attributes['SummonDamage']
          player_stats_attributes[:team_wins_male] = player_stats_json_attributes['TeamWinsMale']
          player_stats_attributes[:wins_assassin] = player_stats_json_attributes['WinsAssassin']
          player_stats_attributes[:wins_warcraft] = player_stats_json_attributes['WinsWarcraft']
          player_stats_attributes[:plays_assassin] = player_stats_json_attributes['PlaysAssassin']
          player_stats_attributes[:plays_war_craft] = player_stats_json_attributes['PlaysWarCraft']
          player_stats_attributes[:team_takedowns] = player_stats_json_attributes['TeamTakedowns']
          player_stats_attributes[:time_on_payload] = player_stats_json_attributes['TimeOnPayload']
          player_stats_attributes[:time_spent_dead] = player_stats_json_attributes['TimeSpentDead']
          player_stats_attributes[:wins_star_craft] = player_stats_json_attributes['WinsStarCraft']
          player_stats_attributes[:meta_experience] = player_stats_json_attributes['MetaExperience']
          player_stats_attributes[:plays_star_craft] = player_stats_json_attributes['PlaysStarCraft']
          player_stats_attributes[:team_wins_diablo] = player_stats_json_attributes['TeamWinsDiablo']
          player_stats_attributes[:team_wins_female] = player_stats_json_attributes['TeamWinsFemale']
          player_stats_attributes[:wins_specialist] = player_stats_json_attributes['WinsSpecialist']
          player_stats_attributes[:forts_destroyed] = player_stats_json_attributes['fortsDestroyed']
          player_stats_attributes[:plays_specialist] = player_stats_json_attributes['PlaysSpecialist']
          player_stats_attributes[:structure_damage] = player_stats_json_attributes['StructureDamage']
          player_stats_attributes[:casted_abilities] = player_stats_json_attributes['castedAbilities']
          player_stats_attributes[:solo_deaths_count] = player_stats_json_attributes['soloDeathsCount']
          player_stats_attributes[:votes_received_by] = player_stats_json_attributes['votesReceivedBy']
          player_stats_attributes[:escapes_performed] = player_stats_json_attributes['EscapesPerformed']
          player_stats_attributes[:merc_camp_captures] = player_stats_json_attributes['MercCampCaptures']
          player_stats_attributes[:on_fire_time_on_fire] = player_stats_json_attributes['OnFireTimeOnFire']
          player_stats_attributes[:team_wins_warcraft] = player_stats_json_attributes['TeamWinsWarcraft']
          player_stats_attributes[:kill_count_minions] = player_stats_json_attributes['killCountMinions']
          player_stats_attributes[:kill_count_neutral] = player_stats_json_attributes['killCountNeutral']
          player_stats_attributes[:regen_globes_taken] = player_stats_json_attributes['regenGlobesTaken']
          player_stats_attributes[:highest_kill_streak] = player_stats_json_attributes['HighestKillStreak']
          player_stats_attributes[:outnumbered_deaths] = player_stats_json_attributes['OutnumberedDeaths']
          player_stats_attributes[:team_wins_star_craft] = player_stats_json_attributes['TeamWinsStarCraft']
          player_stats_attributes[:gardens_plant_damage] = player_stats_json_attributes['GardensPlantDamage']
          player_stats_attributes[:time_c_cd_enemy_heroes] = player_stats_json_attributes['TimeCCdEnemyHeroes']
          player_stats_attributes[:watch_tower_captures] = player_stats_json_attributes['WatchTowerCaptures']
          player_stats_attributes[:kill_count_buildings] = player_stats_json_attributes['killCountBuildings']
          player_stats_attributes[:teamfight_hero_damage] = player_stats_json_attributes['TeamfightHeroDamage']
          player_stats_attributes[:vengeances_performed] = player_stats_json_attributes['VengeancesPerformed']
          player_stats_attributes[:clutch_heals_performed] = player_stats_json_attributes['ClutchHealsPerformed']
          player_stats_attributes[:killed_treasure_goblin] = player_stats_json_attributes['KilledTreasureGoblin']
          player_stats_attributes[:mines_skulls_collected] = player_stats_json_attributes['MinesSkullsCollected']
          player_stats_attributes[:teamfight_damage_taken] = player_stats_json_attributes['TeamfightDamageTaken']
          player_stats_attributes[:teamfight_healing_done] = player_stats_json_attributes['TeamfightHealingDone']
          player_stats_attributes[:gardens_seeds_collected] = player_stats_json_attributes['GardensSeedsCollected']
          player_stats_attributes[:experience_contribution] = player_stats_json_attributes['ExperienceContribution']
          player_stats_attributes[:time_rooting_enemy_heroes] = player_stats_json_attributes['TimeRootingEnemyHeroes']
          player_stats_attributes[:protection_given_to_allies] = player_stats_json_attributes['ProtectionGivenToAllies']
          player_stats_attributes[:time_stunning_enemy_heroes] = player_stats_json_attributes['TimeStunningEnemyHeroes']
          player_stats_attributes[:starcraft_pieces_collected] = player_stats_json_attributes['StarcraftPiecesCollected']
          player_stats_attributes[:time_silencing_enemy_heroes] = player_stats_json_attributes['TimeSilencingEnemyHeroes']
          player_stats_attributes[:end_of_match_award_mvp_boolean] = player_stats_json_attributes['EndOfMatchAwardMVPBoolean']
          player_stats_attributes[:teamfight_escapes_performed] = player_stats_json_attributes['TeamfightEscapesPerformed']
          player_stats_attributes[:lunar_new_year_event_completed] = player_stats_json_attributes['LunarNewYearEventCompleted']
          player_stats_attributes[:starcraft_daily_event_completed] = player_stats_json_attributes['StarcraftDailyEventCompleted']
          player_stats_attributes[:end_of_match_award0_deaths_boolean] = player_stats_json_attributes['EndOfMatchAward0DeathsBoolean']
          player_stats_attributes[:end_of_match_award_hat_trick_boolean] = player_stats_json_attributes['EndOfMatchAwardHatTrickBoolean']
          player_stats_attributes[:end_of_match_award_given_to_nonwinner] = player_stats_json_attributes['EndOfMatchAwardGivenToNonwinner']
          player_stats_attributes[:end_of_match_award_most_kills_boolean] = player_stats_json_attributes['EndOfMatchAwardMostKillsBoolean']
          player_stats_attributes[:end_of_match_award_most_roots_boolean] = player_stats_json_attributes['EndOfMatchAwardMostRootsBoolean']
          player_stats_attributes[:end_of_match_award_most_stuns_boolean] = player_stats_json_attributes['EndOfMatchAwardMostStunsBoolean']
          player_stats_attributes[:end_of_match_award_map_specific_boolean] = player_stats_json_attributes['EndOfMatchAwardMapSpecificBoolean']
          player_stats_attributes[:end_of_match_award_most_escapes_boolean] = player_stats_json_attributes['EndOfMatchAwardMostEscapesBoolean']
          player_stats_attributes[:end_of_match_award_most_healing_boolean] = player_stats_json_attributes['EndOfMatchAwardMostHealingBoolean']
          player_stats_attributes[:lunar_new_year_rooster_event_completed] = player_stats_json_attributes['LunarNewYearRoosterEventCompleted']
          player_stats_attributes[:end_of_match_award_clutch_healer_boolean] = player_stats_json_attributes['EndOfMatchAwardClutchHealerBoolean']
          player_stats_attributes[:end_of_match_award_most_altar_damage_done] = player_stats_json_attributes['EndOfMatchAwardMostAltarDamageDone']
          player_stats_attributes[:end_of_match_award_most_silences_boolean] = player_stats_json_attributes['EndOfMatchAwardMostSilencesBoolean']
          player_stats_attributes[:end_of_match_award_most_coins_paid_boolean] = player_stats_json_attributes['EndOfMatchAwardMostCoinsPaidBoolean']
          player_stats_attributes[:end_of_match_award_most_protection_boolean] = player_stats_json_attributes['EndOfMatchAwardMostProtectionBoolean']
          player_stats_attributes[:lunar_new_year_succesful_artifact_turn_ins] = player_stats_json_attributes['LunarNewYearSuccesfulArtifactTurnIns']
          player_stats_attributes[:end_of_match_award_most_damage_taken_boolean] = player_stats_json_attributes['EndOfMatchAwardMostDamageTakenBoolean']
          player_stats_attributes[:end_of_match_award_most_time_pushing_boolean] = player_stats_json_attributes['EndOfMatchAwardMostTimePushingBoolean']
          player_stats_attributes[:end_of_match_award_most_gems_turned_in_boolean] = player_stats_json_attributes['EndOfMatchAwardMostGemsTurnedInBoolean']
          player_stats_attributes[:end_of_match_award_most_time_in_temple_boolean] = player_stats_json_attributes['EndOfMatchAwardMostTimeInTempleBoolean']
          player_stats_attributes[:end_of_match_award_highest_kill_streak_boolean] = player_stats_json_attributes['EndOfMatchAwardHighestKillStreakBoolean']
          player_stats_attributes[:end_of_match_award0_outnumbered_deaths_boolean] = player_stats_json_attributes['EndOfMatchAward0OutnumberedDeathsBoolean']
          player_stats_attributes[:end_of_match_award_most_damage_to_plants_boolean] = player_stats_json_attributes['EndOfMatchAwardMostDamageToPlantsBoolean']
          player_stats_attributes[:end_of_match_award_most_hero_damage_done_boolean] = player_stats_json_attributes['EndOfMatchAwardMostHeroDamageDoneBoolean']
          player_stats_attributes[:end_of_match_award_most_immortal_damage_boolean] = player_stats_json_attributes['EndOfMatchAwardMostImmortalDamageBoolean']
          player_stats_attributes[:end_of_match_award_most_nuke_damage_done_boolean] = player_stats_json_attributes['EndOfMatchAwardMostNukeDamageDoneBoolean']
          player_stats_attributes[:end_of_match_award_most_xp_contribution_boolean] = player_stats_json_attributes['EndOfMatchAwardMostXPContributionBoolean']
          player_stats_attributes[:end_of_match_award_most_curse_damage_done_boolean] = player_stats_json_attributes['EndOfMatchAwardMostCurseDamageDoneBoolean']
          player_stats_attributes[:end_of_match_award_most_damage_to_minions_boolean] = player_stats_json_attributes['EndOfMatchAwardMostDamageToMinionsBoolean']
          player_stats_attributes[:end_of_match_award_most_siege_damage_done_boolean] = player_stats_json_attributes['EndOfMatchAwardMostSiegeDamageDoneBoolean']
          player_stats_attributes[:end_of_match_award_most_skulls_collected_boolean] = player_stats_json_attributes['EndOfMatchAwardMostSkullsCollectedBoolean']
          player_stats_attributes[:end_of_match_award_most_damage_done_to_zerg_boolean] = player_stats_json_attributes['EndOfMatchAwardMostDamageDoneToZergBoolean']
          player_stats_attributes[:end_of_match_award_most_daredevil_escapes_boolean] = player_stats_json_attributes['EndOfMatchAwardMostDaredevilEscapesBoolean']
          player_stats_attributes[:end_of_match_award_most_merc_camps_captured_boolean] = player_stats_json_attributes['EndOfMatchAwardMostMercCampsCapturedBoolean']
          player_stats_attributes[:end_of_match_award_most_vengeances_performed_boolean] = player_stats_json_attributes['EndOfMatchAwardMostVengeancesPerformedBoolean']
          player_stats_attributes[:end_of_match_award_most_teamfight_damage_taken_boolean] = player_stats_json_attributes['EndOfMatchAwardMostTeamfightDamageTakenBoolean']
          player_stats_attributes[:end_of_match_award_most_teamfight_healing_done_boolean] = player_stats_json_attributes['EndOfMatchAwardMostTeamfightHealingDoneBoolean']
          player_stats_attributes[:end_of_match_award_most_dragon_shrines_captured_boolean] = player_stats_json_attributes['EndOfMatchAwardMostDragonShrinesCapturedBoolean']
          player_stats_attributes[:end_of_match_award_most_teamfight_hero_damage_done_boolean] = player_stats_json_attributes['EndOfMatchAwardMostTeamfightHeroDamageDoneBoolean']
        end
      end
    end
  end
end
