require_relative "../rails_helper.rb"
describe 'Feature Test: User Signup', :type => :feature do

  it 'successfully signs up' do
    visit '/users/new'
    expect(current_path).to eq('/users/new')
    # user_signup method is defined in login_helper.rb
    user_signup
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("FakerNinja")
    expect(page).to have_content("Faker")
    expect(page).to have_content("Ninja")
    expect(page).to have_content("2")
    expect(page).to have_content("I am the best there ever was.")
  end

  it "on sign up, successfully adds a session hash" do
    visit '/users/new'
    # user_signup method is defined in login_helper.rb
    user_signup
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'successfully logs in' do
    
    # user_login method is defined in login_helper.rb
    create_standard_user
    visit '/signin'
    expect(current_path).to eq('/signin')
    user_login
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Aimbot")
    expect(page).to have_content("Austin")
    expect(page).to have_content("Asbury")
    expect(page).to have_content("22")
    expect(page).to have_content("I like to code, play games, and have fun.")
  end

  it "on log in, successfully adds a session hash" do
    create_standard_user
    visit '/signin'
    # user_login method is defined in login_helper.rb
    user_login
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'prevents user from viewing user show page and redirects to home page if not logged in' do
    create_standard_user
    visit '/users/1'
    expect(current_path).to eq('/')
    expect(page).to have_content("Sign Up")
  end
  
end

describe 'Feature Test: User Signout', :type => :feature do

  it 'has a link to log out from the users/show page' do
    visit '/users/new'
    # user_signup method is defined in login_helper.rb
    user_signup
    expect(page).to have_content("Log Out")
  end
  
  it 'redirects to home page after logging out' do
    visit '/users/new'
    # user_signup method is defined in login_helper.rb
    user_signup
    click_link("Log Out")
    expect(current_path).to eq('/')
  end
  
  it "successfully destroys session hash when 'Log Out' is clicked" do
    visit '/users/new'
    # user_signup method is defined in login_helper.rb
    user_signup
    click_link("Log Out")
    expect(page.get_rack_session).to_not include("user_id")
  end

end