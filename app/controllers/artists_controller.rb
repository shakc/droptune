class ArtistsController < ApplicationController
  def index
    @user = current_user

    if @user
      @artists = @user.artists.where.not(name: nil).order(name: :asc)
    else
      @artists = Artist.where.not(name: nil).order(name: :asc).limit(30)
    end
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def follow
    @artist = Artist.find(params[:id])
    
    current_user.artists << @artist

    redirect_to artist_path(@artist)
  end

  def unfollow
    @artist = Artist.find(params[:id])
    
    current_user.follows.where(artist: @artist.id).first.delete

    redirect_to artist_path(@artist)
  end

  def search
    @artists = Artist.basic_search(params[:artist])
  end
end