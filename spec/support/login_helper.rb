module LoginHelper

    def user_signup
      fill_in("user[username]", :with => "FakerNinja")
      fill_in("user[first_name]", :with => "Faker")
      fill_in("user[last_name]", :with => "Ninja")
      fill_in("user[age]", :with => "2")
      fill_in("user[bio]", :with => "I am the best there ever was.")
      fill_in("user[password]", :with => "password")
      click_button('Create User')
    end
  
    def user_login
      fill_in("user[username]", :with => "Aimbot")
      fill_in("password", :with => "password")
      click_button('Sign In')
    end
  
    def create_standard_user 
      @aimbot =  User.create(
        username: "Aimbot",
        first_name: "Austin",
        last_name: "Asbury",
        password: "password",
        age: 22,
        bio: "I like to code, play games, and have fun."
      )
    end
    
  end