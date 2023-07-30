class Api::V1::MarcasController < Api::V1::BaseController
  before_action :set_marca, only: %i[show update destroy]

  def index
    @marcas = policy_scope(Marca)
  end

  def show
    @marca = Marca.find(params[:id])
    authorize @marca
    if @marca
      render json: {
        data: @marca
      }
    end
  end

  def create
    @marca = Marca.new(marca_params)
    authorize @marca
    if @marca.save
      render json: {
        message: 'Uploaded successfully.',
        status: 200,
        marca: @marca
      }, status: :created
    else
      render_error
    end
  end

  def update
    if @marca.update(marca_params)
      render json: {
        message: 'Uploaded successfully.',
        marca: @marca
      }, status: :ok
    else
      render_error
    end
  end

  def destroy
    @marca.destroy
    head :no_content
  end

  private

  def set_marca
    @marca = Marca.find(params[:id])
    authorize @marca
  end

  def marca_params
    params.require(:marca).permit(:name)
  end

  def render_error
    render json: { errors: @marca.errors.full_messages },
           status: :unprocessable_entity
  end
end
