class StaticPagesController < ApplicationController
  include ApiEndpoints

  def home
  end

  def artist
    @search = params['static_pages']['artist']
    artist_response = get_artists_json({'name' => @search})
    @artists = JSON.parse(artist_response)['Artists']
  end

  def events
    @zipcode = params['static_pages']['zipcode']
    event_response = get_events_json({'zipCode' => @zipcode})
    @events = JSON.parse(event_response)['Events']
  end

  def show
  end
end
