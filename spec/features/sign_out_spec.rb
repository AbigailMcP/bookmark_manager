require 'spec_helper'

feature "sign out" do

  scenario "a user should be able to sign out" do
    sign_up
    click_button("Sign out")
    expect(current_path).to eq('/sign_in')
    expect(page).to have_content('Signed out - come back soon')
  end
end
