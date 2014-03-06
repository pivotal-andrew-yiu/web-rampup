class StaticPagesController < ApplicationController
  include ApiEndpoints

  def home
  end

  def artist
    @search = params['static_pages']['artist']
    if @search.empty?
      redirect_to root_path
    else
      artist_response = get_artists_json({'name' => @search})
      @artists = JSON.parse(artist_response)['Artists']
    end
  end

  def show
  end
end
