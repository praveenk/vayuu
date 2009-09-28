class CreateAirportreviews < ActiveRecord::Migration
  def self.up
  	create_table :airportreviews do |t|
    		t.column :airport_id, :string
    		t.column :pilotname, :string
    		t.column :reviewcontent, :string
  	end
  	add_index :airportreviews, :airport_id
  end

  def self.down
  	drop_table :airportreviews
  end
end
