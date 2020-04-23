require_relative "../rails_helper.rb"
describe 'Feature Test: User Signup', :type => :feature do

  it 'offers signup with GitHub' do
    visit '/'
    expect(page).to have_content('Signing in using your Github Account')
  end

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

describe 'Feature Test: Remedies', :type => :feature do

  before :each do
    @user = User.create(
      :username => "Aimbot",
      :first_name => "Austin",
      :last_name => "Asbury",
      :password => "password",
      :age => 22,
      :bio => "I like to code, play games, and have fun."
    )
    @corona = Remedy.create(
      :user_id => @user.id,
      :title => "Cure for Corona",
      :description => "Do a dance, make a little, get down tonight."
    )
    @pepto = Remedy.create(
      :user_id => @user.id,
      :title => "Indigestion Cure",
      :description => "Pepto Bismo"
    )
    @juice = Remedy.create(
      :user_id => @user.id,
      :title => "Juice Cleanse",
      :description => "drink that juice, get healthy."
  )
    visit '/users/new'
    user_signup
  end

  it 'has a link from the user show page to the remedies index page' do
    expect(page).to have_content("See Remedies")
    click_link('See Remedies')
  end

  it 'links from the user show page to the remedies index page' do
    click_link('See Remedies')
    expect(current_path).to eq('/remedies')
  end

  it 'prevents users from editing/deleting/adding remedies on the index page' do
    click_link('See Remedies')
    expect(current_path).to eq('/remedies')
    expect(page).to_not have_content("edit")
    expect(page).to_not have_content("delete")
    expect(page).to_not have_content("new remedy")
  end

  it 'has titles of the remedies on the remedies index page' do
    click_link('See Remedies')
    expect(page).to have_content("#{@corona.title}")
    expect(page).to have_content("#{@juice.title}")
    expect(page).to have_content("#{@pepto.title}")
  end

  it "has links on the remedies index page to the remedies' show pages" do
    click_link('See Remedies')
    expect(page).to have_content("Show #{@corona.title}")
    expect(page).to have_content("Show #{@juice.title}")
    expect(page).to have_content("Show #{@pepto.title}")
  end

  it "links from the remedies index page to the remedies' show pages" do
    click_link('See Remedies')
    click_link("Show #{@pepto.title}")
    expect(current_path).to eq("/users/1/remedies/2")
  end

end