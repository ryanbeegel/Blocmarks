class Topic < ActiveRecord::Base
  has_many :topic_bookmarks
  has_many :bookmarks, through: :topic_bookmarks
end
