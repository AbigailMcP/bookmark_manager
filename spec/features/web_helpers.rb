def create_link(url, title, education)

  visit '/links/new'

  fill_in('url', with: url.to_s)
  fill_in('title', with: title.to_s)
  fill_in('tag', with: education.to_s)
  click_button('Add Link')

end

def sign_up
  visit '/sign_up'
  fill_in('name', with: "James")
  fill_in('email', with: "James@James.com" )
  fill_in('password', with: "password123")
  fill_in('password_confirmation', with: "password123")
  click_button("Sign Up")
end

def mismatching_password_sign_up
  visit '/sign_up'
  fill_in('name', with: "James")
  fill_in('email', with: "James@James.com" )
  fill_in('password', with: "password123")
  fill_in('password_confirmation', with: "hello123")
  click_button("Sign Up")
end

def missing_email_sign_up
  visit '/sign_up'
  fill_in('name', with: "James")
  fill_in('email', with: nil )
  fill_in('password', with: "password123")
  fill_in('password_confirmation', with: "password123")
  click_button("Sign Up")
end

def invalid_email_sign_up
  visit '/sign_up'
  fill_in('name', with: "James")
  fill_in('email', with: "invalidemail" )
  fill_in('password', with: "password123")
  fill_in('password_confirmation', with: "password123")
  click_button("Sign Up")
end

def sign_in
  visit '/sign_in'
  fill_in('email', with: "James@James.com" )
  fill_in('password', with: "password123")
  click_button("Sign In")
end
