module Feeder
  class Site < ActiveRecord::Base
  	
  	has_many :sites_feeds, class_name: Feeder::SitesFeed
  	has_many :feeds, through: :sites_feeds
  	#has_and_belongs_to_many :feeds, foreign_key: 'site_id', class_name: Feeder::Feed, association_foreign_key: 'feed_id'

  	validates :domain, presence: true

  	def title_of_site(site_url)
  		agent = Mechanize.new
  		page = agent.get(site_url)
  		title = @page.title
  		Site.find_or_create_by(domain: site_url, title: title)
  	end

  end
end
