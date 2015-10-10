class SendDailyFeedsWorker

	@queue = :daily_queue

  def self.perform

    users = Nimbos::User.active
    users.each do |user|
    	Feeder::FeedMailer.daily_feeds(user.id).deliver_later
    end
  end

end
