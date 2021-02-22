class ChangeTracksToCompetitions < ActiveRecord::Migration[5.2]
  def change
    rename_table :tracks, :competitions
  end
end
