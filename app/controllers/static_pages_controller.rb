class StaticPagesController < ApplicationController
  include ApiEndpoints

  def home
  end

  def artist
    @search = params['static_pages']['artist']
    if @search.empty?
      flash[:error] = 'Enter the name of a group or artist first!'
      redirect_to root_path
    else
      artist_response = get_artists_response_body({'name' => @search})
      if artist_response
        @artists = JSON.parse(artist_response)['Artists']
      else
        @artists = nil
      end
    end
  end

  def show
  end
end
