module Feeder
  class FeedSource < ActiveRecord::Base

  	has_many :feeds, dependent: :destroy

  	validates :title, presence: true
  	validates :url,   presence: true

  	def create_new_entry(e, fid)
      unless Feed.exists?(['entry_id = ? AND feed_source_id = ?', e.entry_id, fid])
        Feed.create!(
          title:   e.title,
          url:     e.url,
          #content: e.content,
          entry_id: e.entry_id,
          feed_source_id: fid

          )
      end
  	end

    after_create :feed_samples

    private
    def feed_samples
      Resque.enqueue(ResqueWorker)
    end

  end
end
