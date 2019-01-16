class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            # session[:user_id] = @user.id
            flash[:success] = "Welcome to the Beta Blog #{@user.username}!"
            # redirect_to user_path(@user)
            redirect_to articles_path
        else
            render 'new'
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end