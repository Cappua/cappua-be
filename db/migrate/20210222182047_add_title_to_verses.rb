class AddTitleToVerses < ActiveRecord::Migration[5.2]
  def change
    add_column :verses, :title, :string
  end
end
