class Event < ActiveRecord::Base
  attr_accessible :artist_ids, :artist_names, :date, :ticket_url, :venue_id, :venue_name, :user_id, :event_id
  belongs_to :user

  validates :user_id, presence: true
  validates :venue_name, presence: true
  validates :date, presence: true
  validates :event_id, presence: true
end
