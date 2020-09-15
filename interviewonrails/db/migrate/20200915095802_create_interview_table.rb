class CreateInterviewTable < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.datetime :startTime, null: false
      t.datetime :endTime, null: false

      t.references :participant1, references: :users, foreign_key: { to_table: :users}, null: false
      t.references :participant2, references: :users, foreign_key: { to_table: :users}, null: false
      
      t.datetime "created_at", null: true
      t.datetime "updated_at", null: true
    end
  end
end
