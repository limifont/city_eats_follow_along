class RestaurantsController < ApplicationController
  before_action :city
  before_action :restaurant, only: [:show, :edit, :update, :destroy]
  
  def index
    @restaurants = @city.restaurants
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = @city.restaurants.new(restaurant_params)
    if @restaurant.save
      flash[:success] = "Restaurant with name #{@restaurant.name} created!"
      redirect_to city_restaurant_path(@city, @restaurant)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:success] = "Restaurant with name #{@restaurant.name} updated!"
      redirect_to city_restaurant_path(@city, @restaurant)
    else
      render :edit
    end
  end

  def destroy
    restaurant_name = @restaurant.name
    @restaurant.destroy
    flash[:success] = "Restaurant with name #{restaurant_name} destroyed"
    redirect_to city_restaurants_path(@city)
  end

  private

    def restaurant_params
      params.require(:restaurant).permit(:name, 
                                        :food_type,
                                        :cost_rating, 
                                        :open, 
                                        :take_out, 
                                        :alcohol)
    end

    def restaurant
      @restaurant = @city.restaurants.find(params[:id])
    end

    def city
      @city = City.find(params[:city_id])
    end
end
