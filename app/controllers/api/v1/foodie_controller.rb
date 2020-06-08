class Api::V1::FoodieController < ApplicationController

  def show
    google_service = GoogleService.new.get_distance(params[:start], params[:end])
    @entity_info = google_service
  end

end
