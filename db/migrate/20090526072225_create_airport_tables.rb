class CreateAirportTables < ActiveRecord::Migration
  def self.up
  	create_table :airports do |t|
  		t.column :airport_id, :string
  		t.column :airport_type, :string
  		t.column :manager_ph, :string
  		t.column :lat_deg, :integer
  		t.column :lat_min, :integer
  		t.column :lat_sec, :float
  		t.column :latitude, :float
  		t.column :long_deg, :integer
		t.column :long_min, :integer
  		t.column :long_sec, :float
  		t.column :longitude, :float
  		t.column :airport_elev, :integer
  	end
  	add_index :airports, :airport_id
  end
  
  def self.down
  	drop_table :airports
  end
  
end