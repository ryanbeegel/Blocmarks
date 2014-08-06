class Bookmark < ActiveRecord::Base
  has_many :user_bookmarks
  has_many :users, through: :user_bookmarks

  has_many :topic_bookmarks
  has_many :topics, through: :topic_bookmarks

  after_create :get_embedly_url

  private

  def get_embedly_url
    embedly = Embedly::API.new key: ENV['EMBEDLY_KEY'], user_agent: 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
    obj = embedly.oembed url: url unless url.nil?
    self.update_attribute(:embedly_url, obj.first.thumbnail_url)
  end
end
