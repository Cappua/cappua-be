class AddUsersubToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_sub, :string
  end
end
