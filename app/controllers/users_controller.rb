class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def index
        @users = User.all
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            # session[:user_id] = @user.id
            flash[:success] = "Welcome to the Beta Blog #{@user.username}!"
            # redirect_to user_path(@user)
            redirect_to users_path
        else
            render 'new'
        end
    end

    def update
        @user = User.find(params[:id])

        if @user.update(user_params)
            flash[:success] = "Your account was successfully updated"
            # redirect_to user_path(@user)
            redirect_to users_path
        else
            flash[:danger] = "User was not updated"
            redirect_to users_path
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def show
        @user = User.find(params[:id])
    end
    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end