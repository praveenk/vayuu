require 'parsedate'

# This script takes airport_data_v1.csv -- and 
# processes it to be imported via MySqlImport.

# We'll call this three times, once for each .dat file
# Notice that the main loop yields execution to the specialized line parser.
# Each invocation of this function passes a different block to do the actual
# processing distinct to the specific file.

def process_file (input_file, output_file)
  out = File.new(output_file, "w")
  puts "starting on #{input_file}"
  IO.foreach(input_file) do |line|
    out.puts yield(line)
  end
  out.close
  puts " . . done with #{input_file}, created #{output_file}"
end

# airport_data_v1.csv contains locations data. The block passed to process_file selects a subset of fields, and translates the 'S' and 'W' in the lat/lng fields into positive/negative float values
process_file('airport_data_v1.csv','airports.dat')  do |line|
  airport_id, airport_type, manager_ph, comb_lat, comb_long, airport_elev = line.split(',').values_at(1,2,3,4,5,6)
  lat_deg, lat_min, lat_sec = comb_lat.split('-')
 # lat_dir = lat_sec.slice!(-1,1)
  long_deg, long_min, long_sec = comb_long.split('-')
 # long_dir = long_sec.slice!(-1,1)
  
  sign = (lat_dir == 'S') ? -1 : 1
  latitude = sign * (lat_deg.to_f + lat_min.to_f / 60 + lat_sec.to_f/3600)
  sign = (long_dir == 'W') ? -1 : 1
  longitude = sign * (long_deg.to_f + long_min.to_f / 60 + long_sec.to_f/3600)
  [airport_id, airport_type, manager_ph, lat_deg, lat_min, lat_sec, latitude, long_deg, long_min, long_sec, longitude, airport_elev].join('|') 
end

puts "Complete"
