require 'spec_helper'

feature 'Filtering tags' do

  scenario 'a user filters tags' do
    enter_link('http://www.makersacademy.com', 'Makers Academy', 'education')
    enter_link('http://www.google.com', 'Google', 'bubbles')
    visit '/tags/bubbles'
    expect(page).to have_content('Google')
    expect(page).not_to have_content('Makers Academy')
  end

end
