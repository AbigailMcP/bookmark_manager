require 'spec_helper'

feature 'Sign in' do
  before do
    sign_up('Beatrice', 'puppies@gmail.com', 'password123', 'password123')
    Capybara.reset_sessions!
  end

  scenario 'a user signs up' do
    login('puppies@gmail.com', 'password123')
    expect(page).to have_current_path(/links/)
    expect(page).to have_content('Welcome, Beatrice!')
  end

end
