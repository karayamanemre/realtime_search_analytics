require 'text'

class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :search]
  before_action :ensure_admin, only: [:analytics]

  def home
    if user_signed_in?
      redirect_to articles_path
    else
      redirect_to new_user_session_path
    end
  end
  

  def index
    @articles = Article.all
  end

  def search
    user = current_user
    query = search_params[:query]
  
    articles = Article.search(query).map do |article|
      {
        title: article.title,
        content: article.content
      }
    end
  
    save_search_query(user, query)
  
    render json: { articles: articles }
  end

  def analytics
    @search_queries = SearchQuery.includes(:user).order(created_at: :desc)
  end    

  private

  def search_params
    params.permit(:query)
  end

  def save_search_query(user, new_query)
    last_query = SearchQuery.where(user_id: user.id).order(created_at: :desc).first

    if last_query && similar?(new_query, last_query.query)
      last_query.update(query: new_query)
    else
      SearchQuery.create(user_id: user.id, query: new_query)
    end
  end

  def similar?(str1, str2)
    Text::Levenshtein.distance(str1, str2) <= 2
  end

  def ensure_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "You don't have the permission to view this page."
    end
  end
end
