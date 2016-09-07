require 'spec_helper'

feature 'Sign up' do
  before do
    Capybara.reset_sessions!
  end

  scenario 'a user signs up' do
    expect{signup('Beatrice', 'puppies@gmail.com', 'password123', 'password123')}.to change{User.count}.by 1
    expect(page).to have_content('Welcome, Beatrice!')
    expect(User.first.email).to eq 'puppies@gmail.com'
  end

  scenario 'user must confirm password' do
    expect{signup('Beatrice', 'puppies@gmail.com', 'password123', 'password456')}.not_to change{User.count}
    expect(page).not_to have_content('Welcome, Beatrice!')
    expect(User.first).to eq nil
    expect(page).to have_current_path(/signup/)
    expect(page).to have_content('Password and confirmation password do not match')
  end

  scenario 'user must enter email' do
    expect{signup_no_email('Beatrice', 'password123', 'password123')}.not_to change{User.count}
  end

  scenario 'user must enter email in correct format' do
    expect{signup('Beatrice', 'puppies', 'password123', 'password123')}.not_to change{User.count}
  end
end