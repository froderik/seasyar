class CreateIndex < ActiveRecord::Migration
  def self.up
    create_table :seasy_data do |t|
      t.string :key
      t.string :target
      t.integer :id
      t.integer :weight 
      t.timestamps
    end
  end

  def self.down
    drop_table :seasy_data
  end
end
