require 'spec_helper'

feature 'adding tags to links' do

  scenario 'a user adds a tag to a link' do
    enter_link('http://www.makersacademy.com', 'Makers Academy', 'education')
    link = Link.first
    expect(link.tags.map(&:tag)).to include('education')
  end
end
