class ApplicationController < ActionController::Base
	protect_from_forgery

	module ApiEndpoints
		ROOT_API = 'http://api.gifts.com/v2'
		PRODUCT = ROOT_API + '/product'
		SEARCH = ROOT_API + '/search/criteria'
		CATEGORY = SEARCH + '/category'
		RECIPIENT = SEARCH + '/recipient'
		PERSONALITY = SEARCH + '/personality'
		OCCASION = SEARCH + '/occasion'
		API_KEY = 'hxesferyrhsc68hpge645ha8'
	end

	def get_api_param()
		return 'api_key=' + ApiEndpoints::API_KEY
	end

	def append_parameter(uri, key, value)
		return uri + '&' + key + '=' + value
	end

	def get_category_json()
		return HTTParty.get(ApiEndpoints::CATEGORY + '.json?' + get_api_param()).body
	end

	def get_recipient_json()
		return HTTParty.get(ApiEndpoints::RECIPIENT + '.json?' + get_api_param()).body
	end

	def get_personality_json()
		return HTTParty.get(ApiEndpoints::PERSONALITY + '.json?' + get_api_param()).body
	end

	def get_occasion_json()
		return HTTParty.get(ApiEndpoints::OCCASION + '.json?' + get_api_param()).body
	end

	def get_product_json()
		return HTTParty.get(ApiEndpoints::PRODUCT + '.json?' + get_api_param()).body
	end

	def index
    	responseBody = JSON.parse(get_recipient_json())
    	@recipients = responseBody["recipients"]
	end
end
