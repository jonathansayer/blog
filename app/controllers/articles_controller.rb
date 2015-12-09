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
    article_title = params[:article][:title]
    article_body = params[:article][:body]
    Article.create(title:article_title, body: article_body)
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
