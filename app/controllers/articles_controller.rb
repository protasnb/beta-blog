class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  def new
    @article = Article.new
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      flash[:danger] = "Article was not updated"
      redirect_to articles_path
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end

  def create
    # debugger
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  private
    def set_article
      @article =  Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end
end
