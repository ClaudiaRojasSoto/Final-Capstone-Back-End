class Api::ReservationsController < ApplicationController
  before_action :set_car, only: [:create]
  before_action :set_reservation, only: %i[show update destroy]

  def user_reservations
    @reservations = current_user.reservations
    response = @reservations.map(&:reservation_with_car)
    render json: response
  end

  def index
    @reservations = current_user.reservations
    render json: @reservations
  end

  def show
    render json: @reservation
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.car = @car

    if @car.available?(@reservation.start_time, @reservation.end_time)
      if @reservation.save
        render json: {
          success: true,
          reservation_id: @reservation.id,
          user_name: current_user.name,
          car_info: @car.attributes
        }
      else
        render json: { error: @reservation.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Car is not available for reservation' }, status: :unprocessable_entity
    end
  end

  def update
    if @reservation.update(reservation_params)
      render json: { success: true, reservation: @reservation }
    else
      render json: { error: @reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    render json: { success: true, message: 'Reservation was successfully deleted.' }
  end

  private

  def set_car
    @car = Car.find(params[:car_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_time, :end_time, :city)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end
