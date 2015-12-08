class ArticlesController < ApplicationController

  def index
  end

  def new
    redirect_to articles_create_path
  end

  def create
  end

  def save
    article_body = params[:article][:body]
    Article.create(body: article_body)
    redirect_to articles_publish_path
  end

  def publish
  end

end
