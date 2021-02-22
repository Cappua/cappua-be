class RemoveTracksFromVerses < ActiveRecord::Migration[5.2]
  def change
    remove_column :verses, :track_id
  end
end
