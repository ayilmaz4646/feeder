class SiteAnalyzerWorker
	include Sidekiq::Worker

	#sidekiq_options queue: "site_queue"

  def perform(id)
    site = Feeder::Site.find(id)
    site.title_of_site_with_metainspector
    # site.description_of_site_with_metainspector
    # site.keywords_of_site_with_metainspector
    # site.icon_of_site_with_metainspector
  end

end