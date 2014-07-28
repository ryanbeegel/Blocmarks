class CreateUserBookmarks < ActiveRecord::Migration
  def change
    create_table :user_bookmarks do |t|
      t.references :user, index: true
      t.references :bookmark, index: true

      t.timestamps
    end
  end
end
