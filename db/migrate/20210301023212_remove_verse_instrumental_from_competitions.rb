class RemoveVerseInstrumentalFromCompetitions < ActiveRecord::Migration[5.2]
  def change
    remove_column :competitions, :verse_instrumental, :string
  end
end
