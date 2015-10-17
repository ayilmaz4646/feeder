class FeedAnalyzerWorker

	@queue = :feed_queue

  def self.perform(id)

    feed = Feeder::Feed.find(id)
    feed.set_relation_to_sites
    feed.alchemy_get_combined_data
    #feed.text_extraction_with_alchemyapi
  end

end

#http://access.alchemyapi.com/calls/url/URLGetCombinedData?extract=page-image,entity,keyword,title,feed,author,pub-date&apikey=659e042e32b4ca06b7bc735106c2990f45800d24&showSourceText=1&sentiment=1&quotations=1&outputMode=json&url=http://blogs.sonymobile.com/2015/01/22/littlewins-smartwear-ifit-golfshot