class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.references :group
      t.string :name, :null => false
      t.string :timezone, :null => false
      t.binary :data, :limit => 84
      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
