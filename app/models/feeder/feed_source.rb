module Feeder
  class FeedSource < ActiveRecord::Base

  	has_many :feeds, dependent: :destroy

  	validates :title, presence: true
  	validates :url,   presence: true

  	def get_entries
  		updated_feed = Feedjira::Feed.fetch_and_parse(self.url)
  		unless updated_feed.nil?
  			unless updated_feed.entries.nil?
  				updated_feed.entries.each do |entry|
  					create_new_entry(entry, self.id)
  				end
  				self.title = updated_feed.title
          self.url = updated_feed.url
          self.save! 				
  			end
  		end
  	end

  	def create_new_entry(e, fid)
      unless Feed.exists?(condition: [e.entry_id, fid])
        Feed.create!(
          title:   e.title,
          url:     e.url,
          #content: e.content,
          entry_id: e.entry_id,
          feed_source_id: fid

          )
      end
  			
  	end

  end
end
