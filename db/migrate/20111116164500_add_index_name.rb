class AddIndexName < ActiveRecord::Migration
  def self.up
    add_column :seasy_data, :index_name, :string
  end

  def self.down
    remove_column :seasy_data, :index_name
  end  
end