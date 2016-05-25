class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new

  end

  def create
    p params
    Restaurant.create(restaurant_params)
    redirect_to '/restaurants'
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :rating)
  end

end
