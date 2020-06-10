class Api::V1::BackgroundsController < ApplicationController

  def show
    background = BackgroundsService.new.background(params[:location])
    render json: BackgroundSerializer.new(background)
  end

end
