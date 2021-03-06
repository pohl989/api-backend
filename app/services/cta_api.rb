class CtaApi
  include HTTParty

  def transit_routes 
    self.class.get("http://www.transitchicago.com/api/1.0/routes.aspx", @options)
  end 

  #api requires URL query sting method :/ 
  def train_tracker_params_to_url(params)
    params.keys.map{|key| "&#{key.to_s}=#{params[key]}"}.join
  end 

  def train_tracker(params) 
    self.class.get("http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=#{ENV['CTA_TRAIN_TRACKER_SECRET_KEY']}&outputType=JSON#{train_tracker_params_to_url(params)}")
  end 

  def stations 
    self.class.get("https://data.cityofchicago.org/resource/8pix-ypme.json")
  end 

  def find_station(color: "brn", station_name: "Irving Park") 
    stations.select{|c| c[color] && c["station_name"] == station_name }
  end
  
  def train_list
    [
      {code: "red", name: "Red", background_color: "#c82033", color_name: "red"}, 
      {code: "blue", name: "Blue", background_color: "#17a0db", color_name: "blue" }, 
      {code: "g", name: "Green",  background_color: "#119d49", color_name: "green" },
      {code: "brn", name: "Brown",  background_color: "#63361c", color_name: "brown" },
      {code: "p", name: "Purple",  background_color: "#542e91", color_name: "violet" },
      # {code: "pexp", name: "Purple Express",  background_color: "#542e91" },
      {code: "y", name: "Yellow",  background_color: "#f5e50d", color_name: "yellow" }, 
      {code: "pnk", name: "Pink", background_color: "#e37fa7", color_name: "pink" },
      {code: "o", name: "Orange",  background_color: "#ef4925", color_name: "orange" },
    ]

  end 

  def stations_by_train_lines 
    stops = stations
    train_lines.map{|line| { line_code: line, station_names: stops.select{|stop| stop[line] }.map{|c| c["station_name"] }.uniq } }
  end 

  def next_train_from_home
    map_id = find_station.first["map_id"]
    train_data = train_tracker(map_id)
    trains = train_data["ctatt"]["eta"].map do |train|
      parse_train(train)
    end 
  end 

  def next_train_from_work
    map_id = find_station(color: "pnk", station_name: "18th").first["map_id"]
    train_data = train_tracker(map_id)
    trains = train_data["ctatt"]["eta"].map do |train|
      parse_train(train)
    end 
  end 

  def parse_train(train)
    arrival_time = train["arrT"] ? train["arrT"].to_datetime : nil
    human_arrival_time = arrival_time ? arrival_time.strftime("%l:%M %p") : null
    current_time = DateTime.now
    seconds_to_arrival = ((current_time - arrival_time) * 24 * 60 ).to_i
    min_to_arrival = seconds_to_arrival / 60
    msg = "#{min_to_arrival} minutes and #{seconds_to_arrival % min_to_arrival} seconds"
    destination = train["destNm"]
    is_delayed = train["isDly"] == "1" ? true : false
    is_approaching = train["isApp"] == "1" ? true : false
    return {
      msg: msg, 
      arrival_time: arrival_time, 
      destination: destination, 
      is_approaching: is_approaching, 
      is_delayed: is_delayed, 
      human_arrival_time: human_arrival_time,
      current_time: current_time,
      seconds_to_arrival: seconds_to_arrival,
      min_to_arrival: seconds_to_arrival / 60,
      train_info: train,
    }
  end



  def initialize
    @options = {responseType: "JSON" }
    @train_tracker_options = @options.merge(key: ENV["CTA_TRAIN_TRACKER_SECRET_KEY"], mapid: "40380" )
    # @response_body = JSON.parse(@response.body)
  end

end
