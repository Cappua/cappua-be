class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :track_path
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
