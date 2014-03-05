module UsersHelper

	def has_favorite_events?
		!current_user.favorite_events.nil?
	end

end