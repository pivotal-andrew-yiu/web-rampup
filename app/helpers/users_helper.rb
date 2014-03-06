module UsersHelper

	def has_favorite_events?
		current_user.events.any?
	end

end