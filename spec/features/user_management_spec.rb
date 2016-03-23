require 'web_helper'

feature 'user login' do
  scenario 'user count increases by 1 when user creates account' do
    create_account
    expect{create_account}.to change(User, :count).by(1)
  end

  scenario 'redirects to welcome page about account creation' do
    create_account
    expect(page).to have_content 'Welcome test@test.com'
  end

  scenario 'email address is stored in database' do
    create_account
    user = User.first
    expect(user.email).to eq("test@test.com")
  end
end

# rake db:auto_upgrade RACK_ENV=test
