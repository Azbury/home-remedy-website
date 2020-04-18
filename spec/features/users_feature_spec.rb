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

  it 'successfully signs up as admin' do
    visit '/users/new'
    expect(current_path).to eq('/users/new')
    # admin_signup method is defined in login_helper.rb
    admin_signup
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Walt Disney")
    expect(page).to have_content("ADMIN")
  end

  it "on sign up for admin, successfully adds a session hash" do
    visit '/users/new'
    # admin_signup method is defined in login_helper.rb
    admin_signup
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'successfully logs in as admin' do
    create_standard_and_admin_user
    visit '/signin'
    expect(current_path).to eq('/signin')
    # admin_login method is defined in login_helper.rb
    admin_login
    expect(current_path).to eq('/users/2')
    expect(page).to have_content("Walt Disney")
    expect(page).to have_content("ADMIN")
  end

  it "on log in, successfully adds a session hash to admins" do
    create_standard_and_admin_user
    visit '/signin'
    # admin_login method is defined in login_helper.rb
    admin_login
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

end