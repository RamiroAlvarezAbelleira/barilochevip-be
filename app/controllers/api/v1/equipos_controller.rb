class Api::V1::EquiposController < Api::V1::BaseController
  before_action :set_equipo, only: %i[show update destroy]
  def index
    @equipos = if params[:query].present?
      policy_scope(Equipo).global_search(params[:query])
    else
      policy_scope(Equipo)
    end
  end

  def show
    @category = Category.where(“id = ?”, @equipo.category_id)
    @marca = Marca.where(“id = ?”, @equipo.marca_id)
    @bookings = Booking.where(“equipo_id = ?”, @equipo.id)
  end

  def create
    @equipo = Equipo.new(equipo_params)
    authorize @equipo

    if @equipo.save
      render json: {
        message: 'Uploaded successfully.',
        status: 200,
        equipo: @equipo
      }, status: :created
    else
      render_error
    end
  end

  def update
    if @equipo.update(equipo_params)
      render json: {
        message: 'Uploaded successfully.',
        equipo: @equipo
      }, status: :created
    else
      render_error
    end
  end

  def destroy
    @equipo.destroy # if @equipo.user_id == current_user.id
    head :no_content
  end

  private

  def set_equipo
    @equipo = Equipo.find(params[:id])
    authorize @equipo
  end

  def equipo_params
    params.require(:equipo).permit(:name, :price, :description, :stock_total, :category_id, :marca_id, { images: [] })
  end

  def render_error
    render json: { errors: @equipo.errors.full_messages },
           status: :unprocessable_entity
  end
end
