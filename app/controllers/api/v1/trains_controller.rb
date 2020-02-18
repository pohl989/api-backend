class Api::V1::TrainsController < ApplicationController

  def index 
    render json: CtaApi.new.train_list, status: :ok 
  end 
end
