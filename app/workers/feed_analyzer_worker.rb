class FeedAnalyzerWorker

	@queue = :feed_queue

  def self.perform(id)

    feed = Feeder::Feed.find(id)
    feed.text_extraction_with_alchemyapi
    feed.author_extraction_with_alchemyapi
    feed.language_detection_with_alchemyapi
    feed.title_extraction_with_alchemyapi
    feed.publication_date_with_alchemyapi
    feed.set_relation_to_sites
  end

end