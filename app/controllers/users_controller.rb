class UsersController < ApplicationController
  def search_queries
    user = User.find(params[:id])
    queries = user.search_queries.order(created_at: :desc).limit(10).map do |query|
      {
        user_email: user.email,
        query: query.query,
        created_at: query.created_at.strftime('%Y-%m-%d %H:%M:%S')
      }
    end

    render json: queries
  end
end
