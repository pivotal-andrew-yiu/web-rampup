require 'spec_helper'

describe "Authentications" do
	describe "signin" do
  		before { visit signin_path }

	    describe "with no information" do
	    	before { click_button "Submit" }

	    	it { expect(page).to have_content('Invalid email/password combination') }
	    end

	    describe "with valid information" do
	    	let(:user) { FactoryGirl.create(:user) }
	    	before do
	    		fill_in "Email", with: user.email
	    		fill_in "Password", with: user.password
	    		click_button "Submit"
	    	end

	    	it{ expect(page).to have_link('Sign Out', href: signout_path) }
	    	it{ expect(page).to have_content(user.name) }
	    	it{ expect(page).to have_content('Information') }
	    	it{ expect(page).to_not have_link('Sign In', href: signin_path) }

	    	describe " and then signout" do
	    		before do
	    			click_link "Sign Out"
	    		end

		    	it{ expect(page).to_not have_link('Sign Out', href: signout_path) }
		    	it{ expect(page).to have_link('Sign In', href: signin_path) }
		    	it{ expect(page).to have_content('You have signed out!') }
		    end
	    end
	end

	describe "signup" do    
		invalid_user_info = {
			"name" => "a",
			"email" => "a@a.a",
			"password" => "password",
			"password_confirmation" => "password",
			"invalid_email" => "asdfsaf.adfss",
			"short_password" => "alpha",
			"invalid_password_confirmation" => "notpassword"
		}

		before { visit signup_path }

		describe "with no information" do
			before do
				click_button "Create Account"
			end

			it{ expect(page).to have_content('Password digest can\'t be blank') }
			it{ expect(page).to have_content('Name can\'t be blank') }
			it{ expect(page).to have_content('Email can\'t be blank') }
			it{ expect(page).to have_content('Email is invalid') }
			it{ expect(page).to have_content('Password is too short (minimum is 8 characters)') }

	    	it{ expect(page).to_not have_link('Sign Out', href: signout_path) }
	    	it{ expect(page).to have_link('Sign In', href: signin_path) }
		end

		describe "with no name" do
			before do
	    		fill_in "Email", with: invalid_user_info['email']
	    		fill_in "Password", with: "password"
	    		fill_in "Password confirmation", with: "password"
				click_button "Create Account"
			end

			it{ expect(page).to have_content('Name can\'t be blank') }

	    	it{ expect(page).to_not have_link('Sign Out', href: signout_path) }
	    	it{ expect(page).to have_link('Sign In', href: signin_path) }
		end

		describe "with no email" do
			before do
	    		fill_in "Name", with: "Andrew"
	    		fill_in "Password", with: "password"
	    		fill_in "Password confirmation", with: "password"
				click_button "Create Account"
			end
			
			it{ expect(page).to have_content('Email can\'t be blank') }

	    	it{ expect(page).to_not have_link('Sign Out', href: signout_path) }
	    	it{ expect(page).to have_link('Sign In', href: signin_path) }
		end

		describe "with invalid email" do
			before do
				fill_in "Name", with: "Andrew"
	    		fill_in "Email", with: "alphabets"
	    		fill_in "Password", with: "password"
	    		fill_in "Password confirmation", with: "password"
				click_button "Create Account"
			end
			
			it{ expect(page).to have_content('Email is invalid') }

	    	it{ expect(page).to_not have_link('Sign Out', href: signout_path) }
	    	it{ expect(page).to have_link('Sign In', href: signin_path) }
		end

		describe "with no password" do
			before do
				fill_in "Name", with: "Andrew"
	    		fill_in "Email", with: "a@a.com"
	    		fill_in "Password confirmation", with: "password"
				click_button "Create Account"
			end
			
			it{ expect(page).to have_content('Password doesn\'t match confirmation') }
			it{ expect(page).to have_content('Password is too short (minimum is 8 characters)') }
			it{ expect(page).to have_content('Password digest can\'t be blank') }

	    	it{ expect(page).to_not have_link('Sign Out', href: signout_path) }
	    	it{ expect(page).to have_link('Sign In', href: signin_path) }
		end

		describe "with no password confirmation" do
			before do
	    		fill_in "Name", with: "Andrew"
	    		fill_in "Email", with: "a@a.com"
	    		fill_in "Password", with: "password"
				click_button "Create Account"
			end
			
			it{ expect(page).to have_content('Password doesn\'t match confirmation') }

	    	it{ expect(page).to_not have_link('Sign Out', href: signout_path) }
	    	it{ expect(page).to have_link('Sign In', href: signin_path) }
		end

		describe "with short password" do
			before do
	    		fill_in "Name", with: "Andrew"
	    		fill_in "Email", with: "a@a.com"
	    		fill_in "Password", with: "d"
	    		fill_in "Password confirmation", with: "d"
				click_button "Create Account"
			end
			
			it{ expect(page).to have_content('Password is too short (minimum is 8 characters)') }

	    	it{ expect(page).to_not have_link('Sign Out', href: signout_path) }
	    	it{ expect(page).to have_link('Sign In', href: signin_path) }
		end

		describe "with valid information" do
			before do
	    		fill_in "Name", with: "Andrew Yiu"
	    		fill_in "Email", with: "b@b.com"
	    		fill_in "Password", with: "password"
	    		fill_in "Password confirmation", with: "password"
				click_button "Create Account"
			end

			it{ expect(page).to have_content('Welcome!') }

			it{ expect(page).to have_content("Andrew Yiu") }
			it{ expect(page).to have_content("b@b.com") }

	    	it{ expect(page).to have_link('Sign Out', href: signout_path) }
	    	it{ expect(page).to_not have_link('Sign In', href: signin_path) }
		end
	end
end
