require 'spec_helper'

feature 'allow user to sign up' do
  scenario 'user signs up with email and password' do
    sign_up
    expect(page).to have_content ("Welcome, James")
  end

  scenario 'database user count increases by 1' do
    expect{sign_up}.to change{User.count}.by(1)
  end

  scenario 'user email is correct in DB' do
    sign_up
    expect(User.first.email).to eq 'James@James.com'
  end

end