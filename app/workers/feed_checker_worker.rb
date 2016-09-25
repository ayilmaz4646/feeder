class FeedCheckerWorker
	include Sidekiq::Worker

  #sidekiq_options queue: "feed_queue"

  def perform(id)
    feed_source = Feeder::FeedSource.find(id)
    feed_source.get_entries
  end

end