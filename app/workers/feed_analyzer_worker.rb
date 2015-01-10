class FeedAnalyzerWorker

	@queue = :feed_queue

  def self.perform(id)

    feed = Feeder::Feed.find(id)
    feed.text_extraction_with_alchemyapi

  end

end