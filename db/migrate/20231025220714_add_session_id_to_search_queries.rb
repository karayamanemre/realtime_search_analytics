class AddSessionIdToSearchQueries < ActiveRecord::Migration[7.0]
  def change
    add_column :search_queries, :session_id, :string
  end
end
