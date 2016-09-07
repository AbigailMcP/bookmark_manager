require 'spec_helper'

feature 'creating links' do
  scenario 'a user adds a link' do
    enter_link('http://www.makersacademy.com', 'Makers Academy', 'education')
    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end
end
