desc "Update Station List from https://data.cityofchicago.org/resource/8pix-ypme.json"
task :station_update => :environment do
  

  def fetch_stations
    station_data = CtaApi.new.stations
    return JSON.parse(station_data.body) if station_data.ok?
    Rails.logger.warning "unable to get station data from 'https://data.cityofchicago.org/resource/8pix-ypme.json'"
    []
  end

  def station_attributes(station) 
    #I need the keys that don't start with : from the api so I can store the data
    keys = station.keys.select{|key| key.first != ":" } 
    attributes = keys.each_with_object({}){|key, hash| hash[key.to_sym] = station[key]}
  end 

  def new_or_update_station(station) 
    existing_station = Station.find_by_stop_id(station["stop_id"])
    if existing_station
      station.update(station_attributes(station))
    else 
      Station.create(station_attributes(station))
    end 
  end 

  fetch_stations.each do |station|
    new_or_update_station(station)
  end


  puts "Station update complete"

end
