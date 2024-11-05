class SessionsController < ApplicationController
  def new
    @error = nil
  end

  def create
    auth_result = User.authenticate(params[:email], params[:password])

    case auth_result
    when :not_found
      flash.now[:alert] = "No account found with that email address. Please create an account."
      render :new and return
    when :invalid_password
      flash.now[:alert] = "Incorrect password. Please try again."
      render :new and return
    else
      session[:user_id] = auth_result.id
      redirect_to account_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "You have been logged out."
    redirect_to sign_in_path
  end
end