class Api::V1::FoodieController < ApplicationController

  def show
    foodie = FoodieFacade.new(params[:start], params[:end], params[:search])
    foodie_object = foodie.create_foodie_object
    render json: FoodieSerializer.new(foodie_object)
  end

end
