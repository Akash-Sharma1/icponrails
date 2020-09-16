class AddTypeToUser < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :usertype, :string, null: false
  end

  def down
    remove_column :users, :usertype
  end
end
