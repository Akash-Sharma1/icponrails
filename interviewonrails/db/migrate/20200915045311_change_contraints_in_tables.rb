class ChangeContraintsInTables < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :username, :string, null: false, unique: true
    change_column :users, :email, :string, null: false, unique: true
    change_column :interviews, :participant1, :bigint, null:false
    change_column :interviews, :participant2, :bigint, null:false
  end
end
