class AddAdditionalAirportColumns < ActiveRecord::Migration
  def self.up
  	add_column :airports, :airport_name, :string, :limit=>100, :default=>""
  	add_column :airports, :city, :string, :limit=>100, :default=>""
  	add_column :airports, :state, :string, :limit=>5, :default=>""
  	add_column :airports, :fuel_types, :string, :limit=>100, :default=>""
  	add_column :airports, :airport_ownership, :string, :limit=>100, :default=>""
  end

  def self.down
  end
end
