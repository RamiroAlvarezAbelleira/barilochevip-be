class Api::V1::BookingsController < Api::V1::BaseController
  before_action :set_booking, only: %i[show destroy update]

  def index
    @bookings = policy_scope(Booking)
  end

  def show
    if @booking
      render json: {
        data: @booking
      }
    end
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    authorize @booking
    if @booking.save
      render json: {
        message: 'Booked successfully.',
        status: 200,
        booking: @booking
      }, status: :created
    else
      render_error
    end
  end

  def update
    if @booking.update(booking_params)
      render json: {
        message: 'Updated booking successfully.',
        booking: @booking
      }, status: :ok
    else
      render_error
    end
  end

  def destroy
    @booking.destroy
    head :no_content
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def booking_params
    params.require(:booking).permit(:equipo_id, :start_date, :end_date, :quantity)
  end

  def render_error
    render json: { errors: @booking.errors.full_messages },
           status: :unprocessable_entity
  end
end
