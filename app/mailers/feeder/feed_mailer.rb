module Feeder
  class FeedMailer < ActionMailer::Base
  	default :from => %{"Sitescamp" <hello@sitescamp.com>}

  	layout 'mailer'

  	def daily_feeds(user_id)
	  	@user = Nimbos::User.find(user_id)
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