class Bookmark < ActiveRecord::Base
  has_many :user_bookmarks
  has_many :users, through: :user_bookmarks

  has_many :topic_bookmarks
  has_many :topics, through: :topic_bookmarks
end
