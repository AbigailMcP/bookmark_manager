require 'spec_helper'

feature 'Sign up' do
  before do
    Capybara.reset_sessions!
  end

  scenario 'a user signs up' do
    expect{sign_up('Beatrice', 'puppies@gmail.com', 'password123', 'password123')}.to change{User.count}.by 1
    expect(page).to have_content('Welcome, Beatrice!')
    expect(User.first.email).to eq 'puppies@gmail.com'
  end

  scenario 'user must confirm password' do
    expect{sign_up('Beatrice', 'puppies@gmail.com', 'password123', 'password456')}.not_to change{User.count}
    expect(page).not_to have_content('Welcome, Beatrice!')
    expect(User.first).to eq nil
    expect(page).to have_current_path(/signup/)
    expect(page).to have_content('Password does not match the confirmation')
  end

  scenario 'user must enter email' do
    expect{sign_up_no_email('Beatrice', 'password123', 'password123')}.not_to change{User.count}
  end

  scenario 'user must enter email in correct format' do
    expect{sign_up('Beatrice', 'puppies', 'password123', 'password123')}.not_to change{User.count}
  end

  scenario 'user must have unique email' do
    signup('Beatrice', 'puppies@gmail.com', 'password123', 'password123')
    expect{signup('Beatrice', 'puppies@gmail.com', 'password123', 'password123')}.not_to change{User.count}
    expect(page).to have_content('Email is already taken')
  end
end
