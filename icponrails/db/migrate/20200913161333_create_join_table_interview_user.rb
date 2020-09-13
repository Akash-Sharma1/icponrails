class CreateJoinTableInterviewUser < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :interviews do |t|
      t.index [:user_id, :interview_id]
      t.index [:interview_id, :user_id]
    end
  end
end
