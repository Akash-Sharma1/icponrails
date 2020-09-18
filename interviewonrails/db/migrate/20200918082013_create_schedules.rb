class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.references :user, foreign_key: true
      t.references :interview, foreign_key: true

      t.timestamps
    end
  end
end
