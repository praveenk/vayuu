class ViewallairportsController < ApplicationController
 def clustered_airports
 	ne = params[:ne].split(',').collect{|e|e.to_f}
 	sw = params[:sw].split(',').collect{|e|e.to_f}
 	
 	# Get all airports
  airports = Airport.find :all,
    :conditions => ["longitude > ? AND longitude < ? AND latitude <= ? AND latitude >= ? AND airport_type = 'AIRPORT'", sw[1],ne[1],ne[0],sw[0]]
  
  # Max_markers is the maximum number of markers we want in the screen.
  max_markers = 30
  lng_span = 0
  lat_span = 0
  clustered = Hash.new
  
  logger.debug("Starting clustering with #{airports.length} airports")
  
  loop do
     # Each cell in the grid starts out at 1/30th the longitudinal span and then increases in size
    lng_span += (ne[1]-sw[1])/30
    lat_span += (ne[0]-sw[0])/30
    
    #All the clustered airports go into this Hash. The key is the coordinates of the cell
    clustered = Hash.new
    
    airports.each do |airport|
      grid_y = ((airport.latitude-sw[0])/lat_span).floor
      grid_x = ((airport.longitude-sw[1])/lng_span).floor
      
      key = "#{grid_x}_#{grid_y}"
      (clustered[key]=Array.new) if !clustered.has_key?(key)
      clustered[key].push(airport)
    end
    logger.debug("Current clustering has #{clustered.size} elements")
    break unless clustered.length > max_markers
  end
  
  #now determine which cells have cluster of airports and which ones have a single airports
  result = Array.new
  clustered.each_value do |airport_array|
    marker = {:type => 'm',
              :latitude => airport_array[0].latitude,
              :longitude => airport_array[0].longitude,
              :airport_id => airport_array[0].airport_id, 
              :airport_name => airport_array[0].airport_name, 
              :city => airport_array[0].city, 
              :state => airport_array[0].state, 
              :airport_elev => airport_array[0].airport_elev, 
              :manager_ph => airport_array[0].manager_ph, 
              :chart_name => airport_array[0].chart_name, 
              :fuel_types => airport_array[0].fuel_types }
              
    #logger.debug("Airport Id of airport[0] is #{marker[:airport_id]}")
              
    marker[:type] = 'c' if airport_array.size > 1
    result.push(marker)
  end
  render :text => result.to_json  
end
end
