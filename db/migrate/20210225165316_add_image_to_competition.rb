class AddImageToCompetition < ActiveRecord::Migration[5.2]
  def change
    add_column :competitions, :image, :string, default: :null
  end
end
