class Event < ActiveRecord::Base
  attr_accessible :artist_ids, :artist_names, :date, :ticket_url, :venue_id, :venue_name
end
