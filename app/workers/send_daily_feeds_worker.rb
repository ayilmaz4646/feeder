class SendDailyFeedsWorker
	include Sidekiq::Worker

	#sidekiq_options queue: "daily_queue"

  def perform
    users = Nimbos::User.active
    users.each do |user|
    	Feeder::FeedMailer.daily_feeds(user.id).deliver
    end
  end

end
