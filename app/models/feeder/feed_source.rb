module Feeder
  class FeedSource < ActiveRecord::Base

  	has_many :feeds, dependent: :destroy

  	validates :title, presence: true
  	validates :url,   presence: true

  	def get_entries(source_feed)
  		updated_feed = Feedjira::Feed.fetch_and_parse(source_feed.url)
  		unless updated_feed.nil?
  			unless updated_feed.entries.nil?
  				updated_feed.entries.each do |entry|
  					create_new_entry(entry, source_feed)
  				end
  				source_feed.title = updated_feed.title
  				source_feed.url = updated_feed.url
  				source_feed.save!  				
  			end
  		end
  	end

  	def create_new_entry(e, f)
  			Feed.create!(
  				title:          e.title,
  				url:            e.url,
  				content:        e.content
  				)
  	end

  end
end
