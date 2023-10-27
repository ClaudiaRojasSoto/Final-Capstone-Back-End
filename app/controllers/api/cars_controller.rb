class Api::CarsController < ApplicationController
  skip_before_action :set_current_user, only: [:create]
  def index
    @cars = Car.all
    cars_json = @cars.map do |car|
      car_attributes = car.attributes
      car_attributes['image_url'] = url_for(car.image) if car.image.attached?
      car_attributes
    end
    render json: cars_json
  end

  def show
    @car = Car.find(params[:id])
    image_url = url_for(@car.image) if @car.image.attached?
    render json: { car: @car.attributes, image_url: image_url }
  end

  def create
    # Creating a new car instance from the provided parameters.
    @car = Car.new(car_params)

    # Wrapping the save method in a transaction. This ensures that if anything goes wrong,
    # all changes to the database will be rolled back.
    ActiveRecord::Base.transaction do
      if @car.save
        # Handle the image attachment if provided.
        if params[:image].present?
          @car.image.attach(params[:image])
        end

        # If everything goes well, send a success response.
        render json: { message: 'Car created successfully' }, status: :created
      else
        # If the car isn't saved due to validation errors or other issues, send an error response.
        render json: { errors: @car.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    render json: { message: 'Car deleted successfully' }, status: :ok
  end

  private

  def car_params
    params.require(:car).permit(:name, :description, :deposit, :finance_fee, 
                                :option_to_purchase_fee, :total_amount_payable, 
                                :duration, :removed, :image)
  end
  
end
