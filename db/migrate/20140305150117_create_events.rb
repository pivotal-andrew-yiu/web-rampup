class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :date
      t.string :venue_name
      t.string :artist_names
      t.string :ticket_url
      t.integer :venue_id
      t.string :artist_ids

      t.timestamps
    end
  end
end
