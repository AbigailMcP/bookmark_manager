def enter_link(url, title, tag)
  visit '/links/new'
  fill_in('url', with: url)
  fill_in('title', with: title)
  fill_in('tags', with: tag)
  click_button('Add Link')
end
