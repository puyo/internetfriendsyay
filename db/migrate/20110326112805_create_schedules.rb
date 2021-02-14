class CreateSchedules < ActiveRecord::Migration[4.2]
  def up
    create_table :schedules do |t|
      t.string :uuid, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :schedules
  end
end
