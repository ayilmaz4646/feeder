module 
  Feeder
  class FeedSource < ActiveRecord::Base

  	has_many :feeds, dependent: :destroy
    #has_many :followers, through: :user_source
    has_many :user_sources

  	#validates :title, presence: true
  	validates :url,   presence: true, uniqueness: true

    after_create :get_feed_entries, :domain_name_from_url

    def get_entries
      new_feeds = Feedjira::Feed.fetch_and_parse(self.url)
      unless new_feeds.nil?
        unless new_feeds.entries.nil?
          new_feeds.entries.each do |entry|
            create_new_entry(entry, self.id)
          end
          #update_feed_source_info(new_feeds)
        else
          #TODO hiç entries gelmedi hata logu at
          create_error(nil, nil, "no_entries")
        end
      else
        create_error(nil, nil, "rss_source_not_valid")
      end
    end

  	def create_new_entry(e, fid)
      unless Feed.exists?(['entry_id = ? AND feed_source_id = ?', e.entry_id, fid])
        new_feed = Feed.new(title: e.title, url: e.url, content: (e.content||e.summary), 
                            entry_id: e.entry_id, feed_source_id: fid, published_at: e.published, author: e.author)
        if new_feed.valid?
          new_feed.save!
        else
          create_error(new_feed.to_s, new_feed.errors.full_messages.to_s, "feed_not_valid")
        end
      end
  	end

    def domain_name_from_url
      uri = URI.parse(URI.encode(self.url))
      self.domain_name = Domainator.parse(uri)
      #if feedburner kontrolü
      self.title = self.domain_name.split('.').first.upcase + " BLOG"
      save
    end

    def follow(user_id)
      UserSource.find_or_create_by(user_id: user_id, feed_source_id: self.id)
    end

    def unfollow(user_id)
      user_source = UserSource.find_by(user_id: user_id, feed_source_id: self.id)
      user_source.destroy
    end

    def followed_by?(user_id)
      !UserSource.where(user_id: user_id, feed_source_id: self.id).empty?
    end

    def get_feed_entries
      Resque.enqueue(FeedCheckerWorker, self.id)
    end

  private

    def update_feed_source_info(new_rec)
      if self.title != new_rec.title
        self.title = new_rec.title
      end
      self.last_check_time = Time.now
      self.save!
    end

    def create_error(feedParam, errorMessage, errorType)
      FeedError.add_new_error(self.id, feedParam, errorMessage, errorType)
    end
  end
end