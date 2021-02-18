class CreateVerses < ActiveRecord::Migration[5.2]
  def change
    create_table :verses do |t|
      t.string :audio_path
      t.references :user, foreign_key: true
      t.references :track, foreign_key: true

      t.timestamps
    end
  end
end
