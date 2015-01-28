class AddAuthorPublishedAtLikesCountToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :author,       :string
    add_column :feeds, :published_at, :date
    add_column :feeds, :likes_count,  :integer
  end
end
