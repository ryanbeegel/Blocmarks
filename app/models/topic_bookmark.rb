class TopicBookmark < ActiveRecord::Base
  belongs_to :bookmark
  belongs_to :topic
end
