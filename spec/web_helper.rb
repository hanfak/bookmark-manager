def create_account
  visit '/users/new'
  expect(page.status_code).to eq(200)
  fill_in('email', with: 'test@test.com')
  fill_in('password', with: 'qwerty')
  click_button 'Sign up'
end
