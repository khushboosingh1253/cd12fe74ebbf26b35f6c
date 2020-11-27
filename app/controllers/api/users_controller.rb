class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.paginate(page: params[:page], per_page: 3)
    render json: {status: true, users: @users ,message: "List of users"}, code: 200
  end

  # GET /users/1
  def show
    render json: {status: true, user: @user ,message: "User details"}, code: 200
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: {status: true, user: @user ,message: "User was successfully created."}, code: 200
    else
      render json: {status: :unprocessable_entity, message: @user.errors}
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: {status: true, user: @user ,message: "User was successfully updated."}, code: 200
    else
      render json: {status: :unprocessable_entity, message: @user.errors}
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy
      render json: {status: true ,message: "User deleted successfully."}, code: 200
    else
      render json: {status: :unprocessable_entity, message: @user.errors}
    end
  end

  # GET /typeahead/:input
  def search
    @users = User.where("lower(email) LIKE :search OR lower(first_name) LIKE :search OR lower(last_name) LIKE :search", search: "#{params[:input].downcase}%",  search: "#{params[:input].downcase}%",  search: "#{params[:input].downcase}%")
    render json: {status: true, users: @users ,message: "List of users"}, code: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name)
    end
end
