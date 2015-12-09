class ArticlesController < ApplicationController

  def index
    @published = PublishedArticle.all
    render 'show'
  end

  def new
    redirect_to articles_create_path
  end

  def create
  end

  def save
    article = params[:article]
    Article.create(title:article[:title], body: article[:body])
    redirect_to articles_publish_path
  end

  def publish
    @articles = Article.all
  end

  def show
    if params[:title] != nil and params[:body] != nil
      PublishedArticle.create(title: params[:title], body: params[:body])
    end
    @published = PublishedArticle.all
  end

end
