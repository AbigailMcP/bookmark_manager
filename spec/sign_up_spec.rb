require 'spec_helper'
require_relative 'web_helper'

feature 'user sign up' do

  scenario "I can sign up as a new user" do
    expect { signup }.to change(User, :count).by(1)
    expect(page.status_code).to eq(200)
    expect(page).to have_content('Welcome, test@yahoo.com')
    expect(User.first.email).to eq('test@yahoo.com')
  end

  scenario "I cant sign up if my passwords dont match" do
    expect {false_signup}.not_to change(User, :count)
    expect(page.status_code).to eq(200)
  end

end
