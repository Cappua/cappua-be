class AddDescriptionToCompetitions < ActiveRecord::Migration[5.2]
  def change
    add_column :competitions, :description, :string
    add_column :competitions, :genre, :string
    add_column :competitions, :rules, :string
  end
end
