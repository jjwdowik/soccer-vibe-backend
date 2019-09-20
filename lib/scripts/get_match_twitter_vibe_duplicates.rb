# load 'lib/scripts/get_match_twitter_vibe_duplicates.rb'
# task = GetMatchTwitterVibeDuplicates.new
# task.perform

class GetMatchTwitterVibeDuplicates
  def perform
    duplicated_ids = MatchTwitterVibe.group(:twitter_id).having("COUNT(*) > 1").select('unnest((array_agg("id"))[2:])')
    return MatchTwitterVibe.where(id: duplicated_ids)
  end

  def get_full_text_duplicated
    duplicated_ids = MatchTwitterVibe.group(:twitter_full_text).having("COUNT(*) > 1").select('unnest((array_agg("id"))[2:])')
    return MatchTwitterVibe.where(id: duplicated_ids)
  end
end
