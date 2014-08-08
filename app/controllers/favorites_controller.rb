class FavoritesController < ApplicationController
  before_action :set_bookmark

  def create    
    favorite = current_user.favorites.build(bookmark: @bookmark)

    if favorite.save
      flash[:notice] = "It was saved"       
    else
      flash[:error] = "It was not saved" 
    end

    redirect_to :back
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])

    if favorite.destroy
      flash[:notice] = "It was destroyed"       
    else
      flash[:error] = "It was not destroyed" 
    end
    
    redirect_to :back
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:bookmark_id])
  end
end
