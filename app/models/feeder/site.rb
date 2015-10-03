module Feeder
  class Site < ActiveRecord::Base
  	
  	has_many :sites_feeds, class_name: Feeder::SitesFeed
  	has_many :feeds, through: :sites_feeds
  	#has_and_belongs_to_many :feeds, foreign_key: 'site_id', class_name: Feeder::Feed, association_foreign_key: 'feed_id'

  	validates :domain, presence: true

    after_create :analyze_site

    def analyze_site
      Resque.enqueue(SiteAnalyzerWorker, self.id)
    end

    def title_of_site_with_metainspector
      page = MetaInspector.new(self.domain)
      self.title = page.title
      self.description = page.description
      self.keywords = page.meta['keywords']
      self.image_url = page.images.favicon
      save
    end

    # def description_of_site_with_metainspector
    #   page = MetaInspector.new(self.domain)
    #   self.description = page.description
    #   save
    # end

    # def keywords_of_site_with_metainspector
    #   page = MetaInspector.new(self.domain)
    #   self.keywords = page.meta['keywords']
    #   save
    # end

    # def icon_of_site_with_metainspector
    #   page = MetaInspector.new(self.domain)
    #   self.image_url = page.images.favicon
    #   save
    # end




  	# def analyze
  	# 	agent = Mechanize.new
    #   site_url = "http://" + self.domain
  	# 	page  = agent.get(site_url)
  	# 	page_title = page.title
  	# 	self.update(title: page_title)
  	# end

  end
end
