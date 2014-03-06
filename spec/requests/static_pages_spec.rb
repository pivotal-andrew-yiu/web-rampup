require 'spec_helper'

describe "StaticPages" do

	describe "Home Page" do
		it "should have header 'Come Out And Jam'" do
			# Run the generator again with the --webrat flag if you want to use webrat methods/matchers
			visit root_path
			expect(page).to have_content('Come Out And Jam')
		end

		it "should have page title" do
			visit root_path
			expect(page).to have_title('JamBase App')
		end
	end

end
