FactoryGirl.define do
	factory :user do
		name "a"
		email "a@a.a"
		password "password"
		password_confirmation "password"
	end

	factory :invalid_user_info do
		name "a"
		email "a@a.a"
		password "password"
		password_confirmation "password"
		invalid_email "asdfsaf.adfss"
		short_password "alpha"
		invalie_password_confirmation "notpassword"
	end

	factory :search do
		with_results "a"
		with_no_results "lil wayne"
	end
end