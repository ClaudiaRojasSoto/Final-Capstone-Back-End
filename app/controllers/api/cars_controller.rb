class Api::CarsController < ApplicationController
  # skip_before_action :set_current_user, only: [:create]
  def index
    @reservations = current_user.reservations.includes(:car).where(cars: { removed: false })
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
    # rubocop:disable Style/HashSyntax
    render json: { car: @car.attributes, image_url: image_url }
    # rubocop:enable Style/HashSyntax
  end

  def create
    @car = Car.new(car_params)

    ActiveRecord::Base.transaction do
      if @car.save
        @car.image.attach(params[:image]) if params[:image].present?

        render json: { message: 'Car created successfully' }, status: :created
      else
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
