module Feeder
  class Feed < ActiveRecord::Base

  	belongs_to :feed_source
  	has_many   :sites_feeds, class_name: Feeder::SitesFeed
  	has_many   :sites, through: :sites_feeds
  	#has_and_belongs_to_many :sites, foreign_key: 'feed_id', class_name: Feeder::Site, association_foreign_key: 'site_id'

  	validates :title,    presence: true
  	validates :content,  presence:true
  	validates :url,      presence: true

  	after_create :analyze_feed

  	def decomposition_url
  		links = []
  		content.scan(/href\s*=\s*\"*[^\">]*/i) do |link|
      	link = link.sub(/href="/i, "")
      	unless link.nil?
      		link = link.downcase
      		uri = URI.parse(URI.encode(link))
      		link = Domainator.parse(uri)
				end
        links << link
      end
      links
    end

		def analyze_feed
  		Resque.enqueue(FeedAnalyzerWorker, self.id)
  	end

  	def set_relation_to_sites
  		links = decomposition_url
  		links.each do |site_url|
  			site = Site.find_or_create_by(domain: site_url)
  			SitesFeed.find_or_create_by(site_id: site.id, feed_id: self.id)
  		end
  	end

  	def text_extraction_with_alchemyapi
  		AlchemyAPI::Config.output_mode = :json
      content = AlchemyAPI::TextExtraction.new.search(url: self.url)
      #self.content = content
      #self.save
      content
  	end

  	def author_extraction_with_alchemyapi
  		AlchemyAPI::Config.output_mode = :json
      author = AlchemyAPI::AuthorExtraction.new.search(url: self.url)
      author
  	end

  	def language_detection_with_alchemyapi
  		AlchemyAPI::Config.output_mode = :json
      lang = AlchemyAPI::LanguageDetection.new.search(url: self.url)
      #lang1 = lang['language']
  	end

  	def title_extraction_with_alchemyapi
  		AlchemyAPI::Config.output_mode = :json
      title = AlchemyAPI::TitleExtraction.new.search(url: self.url)
      title
  	end

    def like(user_id)
      UserLike.find_or_create_by(user_id: user_id, feed_id: self.id)
    end

    def liked_by?(user_id)
      !UserLike.where(user_id: user_id, feed_id: self.id).empty?
    end
  	
  end
end
