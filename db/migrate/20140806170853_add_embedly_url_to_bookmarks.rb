class AddEmbedlyUrlToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :embedly_url, :string
  end
end
