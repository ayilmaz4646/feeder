module 
  Feeder
  class FeedSource < ActiveRecord::Base

  	has_many :feeds, dependent: :destroy

  	validates :title, presence: true
  	validates :url,   presence: true

    after_create :get_feed_entries

    def get_entries(feed_source)
      updated_feed = Feedjira::Feed.fetch_and_parse(self.url)
      unless updated_feed.nil?
        unless updated_feed.entries.nil?
          updated_feed.entries.each do |entry|
            create_new_entry(entry, feed_source.id)
          end
          feed_source.title = updated_feed.title
          feed_source.url = updated_feed.url
          feed_source.save!        
        end
      end
    end

  	def create_new_entry(e, fid)
      unless Feed.exists?(['entry_id = ? AND feed_source_id = ?', e.entry_id, fid])
        Feed.create!(
          title:   e.title,
          url:     e.url,
          content: e.content,
          entry_id: e.entry_id,
          feed_source_id: fid
        )
      end
  	end

    private

    def get_feed_entries
      Resque.enqueue(FeedCheckerWorker, self.id)
    end

  end
end