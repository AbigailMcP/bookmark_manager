require 'spec_helper'

feature 'Sign up' do
  scenario 'a user signs up' do
    expect{signup('Beatrice', 'puppies@gmail.com', 'password123')}.to change(User, :count).by 1
    expect(page).to have_content('Welcome, Beatrice!')
    expect(User.first.email).to eq 'puppies@gmail.com'
  end
end
