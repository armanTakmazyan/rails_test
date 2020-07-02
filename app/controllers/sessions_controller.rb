class SessionsController < ApplicationController

    before_action :must_be_not_authenticated, only: [:new, :create]


    def new
    end

    def create
        if user = User.authenticate(params[:email], params[:password])
          session[:user_id] = user.id
          flash[:notice] = "Welcome back, #{user.email}!"
          redirect_to(session[:intended_url] || employees_path)
          session[:intended_url] = nil
        else
          flash.now[:alert] = "Invalid email/password combination!"
          render :new
        end
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to login_path, notice: "You're now signed out!"
    end
end
