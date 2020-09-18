class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.datetime :startTime, null: false
      t.datetime :endTime, null: false
      t.timestamps
    end
  end
end
