def enter_link(url, title, tag)
  visit '/links/new'
  fill_in('url', with: url)
  fill_in('title', with: title)
  fill_in('tags', with: tag)
  click_button('Add Link')
end

def sign_up(name, email, password, password_confirmation)
  visit '/signup'
  fill_in('name', with: name)
  fill_in('email', with: email)
  fill_in('password', with: password)
  fill_in('password_confirmation', with: password_confirmation)
  click_button('Sign up')
end

def sign_up_no_email(name, password, password_confirmation)
  visit '/signup'
  fill_in('name', with: name)
  fill_in('password', with: password)
  fill_in('password_confirmation', with: password_confirmation)
  click_button('Sign up')
end

def login(email, password)
  visit '/login'
  fill_in('email', with: email)
  fill_in('password', with: password)
  click_button('Sign in')
end
