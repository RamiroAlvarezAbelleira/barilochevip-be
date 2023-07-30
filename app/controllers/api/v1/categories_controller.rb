class Api::V1::CategoriesController < Api::V1::BaseController
  before_action :set_category, only: %i[show update destroy]

  def index
    @categories = policy_scope(Category)
  end

  def show
    @category = Category.find(params[:id])
    authorize @category
    if @category
      render json: {
        data: @category
      }
    end
  end

  def create
    @category = Category.new(category_params)
    authorize @category
    if @category.save
      render json: {
        message: 'Uploaded successfully.',
        status: 200,
        category: @category
      }, status: :created
    else
      render_error
    end
  end

  def update
    if @category.update(category_params)
      render json: {
        message: 'Uploaded successfully.',
        category: @category
      }, status: :ok
    else
      render_error
    end
  end

  def destroy
    @category.destroy
    head :no_content
  end

  private

  def set_category
    @category = Category.find(params[:id])
    authorize @category
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def render_error
    render json: { errors: @category.errors.full_messages },
           status: :unprocessable_entity
  end
end
