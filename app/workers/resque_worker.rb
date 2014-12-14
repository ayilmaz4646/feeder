class ResqueWorker
	
  @queue = :feed_queue

  def self.perform(feed_source_id)

    feed = Feeder::FeedSource.find(feed_source_id)
    Feeder::FeedSource.feed_source_created(feed).deliver

  end

end