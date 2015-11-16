module Feeder
  class Feed < ActiveRecord::Base

  	belongs_to :feed_source
  	has_many   :sites_feeds, class_name: Feeder::SitesFeed
  	has_many   :sites, through: :sites_feeds
    has_many   :user_readlaters
    has_many   :user_likes
  	#has_and_belongs_to_many :sites, foreign_key: 'feed_id', class_name: Feeder::Site, association_foreign_key: 'site_id'

  	validates :title,    presence: true
  	#validates :content,  presence:true
  	validates :url,      presence: true

  	after_create :analyze_feed#, :send_emails

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

    def alchemy_get_combined_data
      alchemyapi = Feeder::Alchemyapi.new()
      response = alchemyapi.combined('url', self.url, { 'extract'=>'page-image,taxonomy,title,author,pub-date' })
      if response['status'] == 'OK'

        #if response.key?('image')
         # self.image_url = response['image']
        #end
        if response.key?('title')
          self.title = response['title']
        end
        if response.key?('author')
          self.author = response['author']
        end
        if response.key?('url')
          self.url = response['url']
        end
        if response.key?('language')
          self.language = response['language']
        end
        if response.key?('publicationDate')
          self.published_at = Date.parse(response['publicationDate']['date'])
        end
        self.analyzed = true
        self.save
        # if response.key?('taxonomy')
        #   puts 'Entities:'
        #   for entity in response['taxonomy']
        #     puts "\trelevance: " + entity['label']
        #     puts "\ttext: "      + entity['score']
        #   end
        # end
      else
        puts 'Error in combined call: ' + response['statusInfo']
      end      
    end

    # def text_extraction_with_alchemyapi
    #   AlchemyAPI::Config.output_mode = :json
    #   new_content = AlchemyAPI::TextExtraction.new.search(url: self.url)
    #   new_content
    # end

    def like(user_id)
      UserLike.find_or_create_by(user_id: user_id, feed_id: self.id)
    end

    def unlike(user_id)
      user_like = UserLike.find_by(user_id: user_id, feed_id: self.id)
      user_like.destroy
    end

    def liked_by?(user_id)
      !UserLike.where(user_id: user_id, feed_id: self.id).empty?
    end

    def readlater(user_id)
      UserReadlater.find_or_create_by(user_id: user_id, feed_id: self.id)
    end

    def undo_readlater(user_id)
      readlater = UserReadlater.find_by(user_id: user_id, feed_id: self.id)
      readlater.destroy
    end

    def readlater_by?(user_id)
      !UserReadlater.where(user_id: user_id, feed_id: self.id).empty?
    end

    def user_readlater(user_id)
      UserReadlater.later_readings_of_user(user_id)
    end

    def user_like(user_id)
      UserLike.likes_of_user(user_id)
    end

    def self.user_feeds(user_id)

    end

    def send_emails
      users = Nimbos::User.active
      users.each do |user|
        FeedMailer.daily_feeds(user.id).deliver_later!(wait: 10.seconds)
      end
    end

  private
    def decomposition_url
      links = []
      content.scan(/href\s*=\s*\"*[^\">]*/i) do |link|
        link = link.sub(/href="/i, "").to_s.strip

        if valid_url?(link)
          link = link.downcase
          uri = URI.parse(URI.encode(link))
          link = Domainator.parse(uri)
        end
        links << link
      end
      links
    end

    def valid_url?(url)
      !url.nil? && !url.include?("localhost")
    end

  end
end
