class ResqueWorker
	
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

end