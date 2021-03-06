class Api::UsersController < ApplicationController
  before_action :authorize, except: [:create, :update]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @current_user
  end

  # POST /users
  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: user, status: :created
  end

  # PATCH/PUT /users/1
  def update
    user = User.find(params[:id])
    user.update!(password: params[:password])

    render json: user, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params
      .require(:user)
      .permit(
        :id,
        :username,
        :first_name,
        :last_name,
        :email,
        :phone,
        :role_id,
        :password_digest,
        :avatar_url,
        :team_id,
      )
  end
end
