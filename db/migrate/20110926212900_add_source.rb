class AddSource < ActiveRecord::Migration
  def self.up
    add_column :seasy_data, :source, :string
  end

  def self.down
    remove_column :seasy_data, :source
  end
end
