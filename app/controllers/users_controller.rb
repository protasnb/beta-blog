class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def new
        @user = User.new
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
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
    end

    def show
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end


    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
        if current_user != @user #&& !current_user.admin?
            flash[:danger] = "You can only edit your own account"
            redirect_to root_path
        end
    end
end