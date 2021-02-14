class CreateSchedules < ActiveRecord::Migration
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
