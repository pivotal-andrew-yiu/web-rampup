class AddFavoriteEventsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_events, :string
  end
end
