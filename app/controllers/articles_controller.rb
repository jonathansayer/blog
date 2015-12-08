class ArticlesController < ApplicationController

  def index
  end

  def new
    redirect_to articles_create_path
  end

  def create
  end

  def save
    article_title = params[:article][:title]
    article_body = params[:article][:body]
    Article.create(title:article_title, body: article_body)
    redirect_to articles_publish_path
  end

  def publish
    @articles = Article.all
  end

  def show
    PublishedArticle.create(title: params[:title], body: params[:body])
    @published = PublishedArticle.all
  end

end
