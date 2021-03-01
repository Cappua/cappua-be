class AddVerseInstrumentalToCompetitions < ActiveRecord::Migration[5.2]
  def change
    add_column :competitions, :verse_instrumental, :string
  end
end
