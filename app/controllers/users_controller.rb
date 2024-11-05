class UsersController < ApplicationController
  before_action :require_login, only: [:account]

  def new
    @user = User.new 
  end

  def account
    @user = current_user
    render :account
  end

  def create
    if params[:user].nil? && params[:email].present? && params[:password].present?
        params[:user] = { email: params[:email], password: params[:password] }
    end

    existing_user = User.find_by(email: user_params[:email])
    
    if existing_user
      flash.now[:alert] = "An account with that email address already exists."
      render :new and return
    end

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to account_path, notice: 'User created successfully.'
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password) 
  end

  def require_login
    redirect_to sign_in_path, alert: 'Please sign in to access this page.' unless current_user
  end
end