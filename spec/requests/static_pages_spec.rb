require 'spec_helper'

describe "StaticPages" do
	describe "Home Page" do
		before do
			visit root_path
		end

		it "should have header 'Come Out And Jam'" do
			expect(page).to have_content('Come Out And Jam')
		end

		it "should have page title" do
			expect(page).to have_title('JamBase App')
		end

		it "should have search form" do
			expect(page).to have_button('Search')
			expect(page).to have_field('Enter Artist / Group')
			expect(page).to have_field('Enter Zip Code')
		end

		describe "search" do
			describe "for artist" do
				describe "with empty entry" do
					before do
						click_button "Search Artist / Group"
					end

					it { expect(page).to have_content('Enter the name of a group or artist first!') }
				end

				describe "with non-empty entry" do
					before do
						fill_in "Enter Artist / Group", with: "a"
						click_button "Search Artist / Group"
					end

					it { expect(page).to have_content('Search Results for:') }
				end				
			end

			describe "for location" do
				describe "with empty zipcode" do
					before do
						click_button "Search Location"
					end

					it { expect(page).to have_content('Invalid Zip Code') }
				end

				describe "with long zipcode" do
					before do
						fill_in "Enter Zip Code", with: "123456"
						click_button "Search Location"
					end

					it { expect(page).to have_content('Invalid Zip Code') }
				end

				describe "with short zipcode" do
					before do
						fill_in "Enter Zip Code", with: "1234"
						click_button "Search Location"
					end

					it { expect(page).to have_content('Invalid Zip Code') }
				end

				describe "with short non-numeric zipcode" do
					before do
						fill_in "Enter Zip Code", with: "hey4"
						click_button "Search Location"
					end

					it { expect(page).to have_content('Invalid Zip Code') }
				end

				describe "with long non-numeric zipcode" do
					before do
						fill_in "Enter Zip Code", with: "alphabetical124"
						click_button "Search Location"
					end

					it { expect(page).to have_content('Invalid Zip Code') }
				end

				describe "with valid zipcode" do
					before do
						fill_in "Enter Zip Code", with: "12345"
						click_button "Search Location"
					end

					it { expect(page).to have_content('Listing events in the 12345 area') }
				end	
			end
		end
	end

	describe "Artist Page" do
		search = {
			"with_results" => "a",
			"with_no_results" => "lil wayne"
		}

		describe "with seach term that has results" do
			before do
				visit artists_path({'static_pages' => {'artist' => search['with_results']}})
			end

			it "should have search results header" do
				expect(page).to have_content('Search Results for:')
				expect(page).to have_content(search['with_results'])
			end

			it "should not have no results text" do
				expect(page).to_not have_content('Sorry, no results')
			end
		end

		describe "with seach term that has no results" do
			before do
				visit artists_path({'static_pages' => {'artist' => search['with_no_results']}})
			end

			it "should have search results header" do
				expect(page).to have_content('Search Results for:')
				expect(page).to have_content(search['with_no_results'])
			end

			it "should have no results text" do
				expect(page).to have_content('Sorry, no results')
			end
		end
	end
end
