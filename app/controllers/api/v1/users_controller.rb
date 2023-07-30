class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_user, only: %i[show update]

  def index
    @users = policy_scope(User)
  end

  def show
  end

  def create
    @user = User.new(user_params)
    authorize @user
    if @user.save
      render json: {
        message: 'Signed up successfully.',
        status: 200,
        user: @user
      }, status: :created
    else
      render_error
    end
  end

  def update
    if @user.update(user_params) && @user.id == current_user.id
      render :show
    else
      render_error
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user  # For Pundit
  end

  def user_params
    params.require(:user).permit(:email, :password, :name, :nickname)
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
           status: :unprocessable_entity
  end
end
