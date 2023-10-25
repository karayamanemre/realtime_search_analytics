class ArticlesController < ApplicationController
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
    @users = User.all
    @search_queries = SearchQuery.includes(:user).order(created_at: :desc)
    @most_searched_queries = SearchQuery.group(:query).order('count_id DESC').limit(10).count(:id)
  end

  private

  def search_params
    params.permit(:query)
  end

  def save_search_query(user, new_query)
    new_query = new_query.strip
    return if new_query.strip.empty?

    # Gets the most recent search query record for the current user
    last_query_record = SearchQuery.where(user_id: user.id).order(created_at: :desc).first
    
    # If there is a previous record
    if last_query_record
      # Calculates the time difference between now and the last query's creation time
      time_difference = Time.current - last_query_record.created_at
  
      # Checks if the time difference is less than 5 seconds
      if time_difference < 5.seconds
        # If the new query is longer than the last one, updates the last record
        if new_query.length > last_query_record.query.length
          last_query_record.update(query: new_query, created_at: Time.current)
        end
        # If it's shorter or the same length, the code doesn't saves or updates anything
      else
        # If more than 5 seconds passed since the last query, creates a new record with a new session ID
        SearchQuery.create(user_id: user.id, query: new_query, session_id: SecureRandom.uuid)
      end
    else
      # If there's no previous record for this user, creates a new record with a new session ID
      SearchQuery.create(user_id: user.id, query: new_query, session_id: SecureRandom.uuid)
    end
  end

  def ensure_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "You don't have the permission to view this page."
    end
  end
end
