class ApplicationController < ActionController::Base
	protect_from_forgery
	include SessionsHelper
	include UsersHelper

	module ApiEndpoints
		ROOT_API = 'http://api.jambase.com'
		EVENTS = ROOT_API + '/events?'
		ARTISTS = ROOT_API + '/artists?'
		VENUES = ROOT_API + '/venues?'
		# api key 1
		# API_KEY = '6agbnnahmx35snemrxx5pgwe'
		# api key 2
		API_KEY = 'bsr4tbszdqpawzpet8zk8wyk'
		# api key 3
		# API_KEY = 'rrwx9b43vpzppzc366vhb75h'
		# api key 4
		# API_KEY = 'xd7kby7w5awu2ywkpp23y4eh'

		def get_response_body(response)
			if response.code == 200
				return response.body
			else
				return nil
			end
		end

		def get_api_key_param
			return { 'api_key' => ApiEndpoints::API_KEY }
		end

		def get_parameter(key, value)
			return key + '=' + value + '&'
		end

		def build_uri(endpoint, params)
			return endpoint + params.to_query
		end

		def get_artists_response_body(params)
			return get_response_body(HTTParty.get(build_uri(ApiEndpoints::ARTISTS, params.merge(get_api_key_param))))
		end

		def get_venues_response_body(params)
			return get_response_body(HTTParty.get(build_uri(ApiEndpoints::VENUES, params.merge(get_api_key_param))))
		end

		def get_events_response_body(params)
			return get_response_body(HTTParty.get(build_uri(ApiEndpoints::EVENTS, params.merge(get_api_key_param))))
		end
	end	
end
