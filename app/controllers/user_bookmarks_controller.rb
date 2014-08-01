class UserBookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks
    # @likes = current_user.liked_bookmarks
  end
end