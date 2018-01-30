class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:logged_in_user] = @user.id
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    login = params[:username]
    user = User.find_by(username: login)

    if user
      session[:logged_in_user] = user.id
      render json: { session: user }, status: :ok
    else
      # session[:logged_in_user] = nil
      # render json: { session: nil },

      render json: { user: nil }
    end
  end

  def logout

    session[:logged_in_user] = nil
    render json: { session: nil }, status: :ok
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:username, :name)
    end
end
