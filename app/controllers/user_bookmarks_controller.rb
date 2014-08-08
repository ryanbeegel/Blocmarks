class UserBookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks
    @favorite_bookmarks = current_user.favorites.collect(&:bookmark).uniq
  end
end