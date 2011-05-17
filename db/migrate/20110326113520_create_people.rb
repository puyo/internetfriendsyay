class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.references :group
      t.string :name, :null => false
      t.string :timezone, :null => false
      t.binary :data
      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
