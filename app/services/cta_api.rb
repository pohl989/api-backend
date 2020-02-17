class CtaApi
  include HTTParty

  def transit_routes 
    self.class.get("http://www.transitchicago.com/api/1.0/routes.aspx", @options)
  end 

  def trains(mapid) 
    self.class.get("http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=#{ENV['CTA_TRAIN_TRACKER_SECRET_KEY']}&mapid=#{mapid}&outputType=JSON")
  end 

  def stations 
    self.class.get("https://data.cityofchicago.org/resource/8pix-ypme.json")
  end 

  def find_station(color: "brn", station_name: "Irving Park") 
    stations.select{|c| c[color] && c["station_name"] == station_name }
  end 

  def next_train_from_home
    map_id = find_station.first["map_id"]
    train_data = trains(map_id)
    trains = train_data["ctatt"]["eta"].map do |train|
      parse_data_from_train(train)
    end 
  end 

  def parse_data_from_train(train)
    arrival_time = train["arrT"] ? train["arrT"].to_time : nil
    human_arrival_time = arrival_time ? arrival_time.strftime("%l:%M %p") : null
    destination = train["destNm"]
    is_delayed = train["isDly"] == "1" ? true : false
    is_approaching = train["isApp"] == "1" ? true : false
    return {arrival_time: arrival_time, destination: destination, is_approaching: is_approaching, is_delayed: is_delayed, human_arrival_time: human_arrival_time}
  end 



  def initialize
    @options = {responseType: "JSON" }
    @train_tracker_options = @options.merge(key: ENV["CTA_TRAIN_TRACKER_SECRET_KEY"], mapid: "40380" )
    # @response_body = JSON.parse(@response.body)
  end

end
