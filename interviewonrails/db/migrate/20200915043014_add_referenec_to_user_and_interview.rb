class AddReferenecToUserAndInterview < ActiveRecord::Migration[5.1]
  def change
    add_column :interviews, :participant1, :bigint 
    add_column :interviews, :participant2, :bigint
  end
end
