module Feeder
  class FeedMailer < ApplicationMailer
  	default from: "hello@sitescamp.com"

  	layout 'mailer'

  	def daily_feeds
	  	@user = Nimbos::User.find(params[:user_id])
      feed_sources_ids = Feeder::UserSource.where(user_id: @user.id).pluck(:feed_source_id)
      @feeds = Feeder::Feed.where(feed_source_id: feed_sources_ids, published_at: Time.zone.yesterday)
	    locale = @user.language
	    @email_title = default_i18n_subject
	    I18n.with_locale(locale) do
      	mail(to: @user.email)
    	end
	  end

  end
end