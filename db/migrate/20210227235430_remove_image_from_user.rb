class RemoveImageFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :image, :binary
    add_column :users, :image, :string, default: :null
  end
end
