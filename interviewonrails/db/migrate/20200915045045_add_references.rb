class AddReferences < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :interviews, :users, column: :participant1
    add_foreign_key :interviews, :users, column: :participant2
  end
end
