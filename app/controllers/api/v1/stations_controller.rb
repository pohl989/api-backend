class Api::V1::StationsController < ApplicationController

  def index 
    stations_data = CtaApi.new.stations
    # I'm doing this because I don't want to wait for the Heroku server to warm up if I don't have to
    # I'll either get the station data from the City of Chicago or start up the database
    if stations_data.ok? 
      render json: stations_data.body, status: :ok 
    else 
      render json: Station.all, status: :ok 
    end 
    
  end 

end
