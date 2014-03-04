module ApplicationHelper

	module ApiEndpoints
		ROOT_API = 'http://api.jambase.com'
		EVENTS = ROOT_API + '/events?'
		ARTISTS = ROOT_API + '/artists?'
		VENUES = ROOT_API + '/venues?'
		API_KEY = '6agbnnahmx35snemrxx5pgwe'
	end

	def get_api_param()
		return 'api_key=' + ApiEndpoints::API_KEY
	end

	def get_parameter(key, value)
		return key + '=' + value + '&'
	end

	def get_artists_json(params)
		return HTTParty.get(ApiEndpoints::ARTISTS + get_api_param()).body
	end

	def get_venues_json(params)
		return HTTParty.get(ApiEndpoints::VENUES + get_api_param()).body
	end

	def get_events_json(params)
		return HTTParty.get(ApiEndpoints::EVENTS + get_api_param()).body
	end

	def flash_class(key)
		case key
			when :notice then "alert alert-info"
	        when :success then "alert alert-success"
	        when :error then "alert alert-danger"
	        when :alert then "alert alert-warning"
	    end
	end

end
