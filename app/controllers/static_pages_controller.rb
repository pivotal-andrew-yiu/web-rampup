class StaticPagesController < ApplicationController
  def home
  end

  def artist
  end

  def search_artist
  	puts 'search artist'
  	redirect_to root_path
  end

  def search_zipcode
  	puts 'search zipcode'
  	redirect_to root_path
  end

  def show
  end
end
