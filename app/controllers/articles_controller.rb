class ArticlesController < ApplicationController

  def index
  end

  def new
    redirect_to articles_create_path
  end

  def create
  end

  def save
    redirect_to articles_publish_path
  end

  def publish
  end

end
