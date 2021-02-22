class AddCompetitionsToVerses < ActiveRecord::Migration[5.2]
  def change
    add_reference :verses, :competition, foreign_key: true
  end
end
