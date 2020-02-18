class Api::V1::TrainTrackerController < ApplicationController

  def index 
    tracker = CtaApi.new.train_tracker(train_tracker_params)
    if tracker.ok? 
      render json: tracker.body, status: :ok
    else  
      render json: tracker.body, status: :unprocessable_entity
    end
  end
  
  private 

  #3rd party api accepts these 4 parameters
  #mapid == station; @stpid == stop; max == max results returned; rt == filtered by route
  def train_tracker_params
    params.permit(:mapid, :stpid, :max, :rt)
  end

end
