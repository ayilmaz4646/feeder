class FeedCheckerWorker
	
  @queue = :feed_queue

  def self.perform(id)

    feed_source = Feeder::FeedSource.find(id)
    feed_source.get_entries

  end

end