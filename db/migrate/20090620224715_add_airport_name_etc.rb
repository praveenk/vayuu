class AddAirportNameEtc < ActiveRecord::Migration
  def self.up
   	add_column :airports, :chart_name, :string, :limit=>100, :default=>""
  end

  def self.down
  	remove_column :airports, :chart_name
  end
end
