class ShowairportsController < ApplicationController
 def map
 	locations=Airport.find(:all, :conditions => "longitude > -124 and longitude < -120 and latitude > 36 and latitude < 38 and airport_type = 'AIRPORT'")
 	#locations=Airport.find(:all, :conditions => "airport_id = 'SFO' OR airport_id = 'SJC'")
 	@airportdots=Array.new
 	locations.each do |s|
 		@airportdots.push({:latitude=>s.latitude, :longitude=>s.longitude, :airport_id=>s.airport_id, :airport_name=>s.airport_name, :city=>s.city, :state=>s.state, :airport_elev=>s.airport_elev, :manager_ph=>s.manager_ph, :chart_name=>s.chart_name, :fuel_types=>s.fuel_types})
	end	
 end
end
