require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) {
    User.create(
      :username => "Aimbot",
      :first_name => "Austin",
      :last_name => "Asbury",
      :password => "password",
      :age => 22,
      :bio => "I like to code, play games, and have fun."
    )
  }

  let(:user2) {
    User.create(
      :username => "Scrub",
      :first_name => "Harry",
      :last_name => "Larry",
      :password => "password",
      :age => 60,
      :bio => "I like to code, play games, and have no fun."
    )
  }

  let(:corona_cure) {
    Remedy.create(
      :user_id => user2.id,
      :title => "Cure for Corona",
      :description => "Do a dance, make a little, get down tonight."
    )
  }

  let(:indigestion_cure) {
    Remedy.create(
      :user_id => user2.id,
      :title => "Indigestion Cure",
      :description => "Pepto Bismo"
    )
  }

  it "is valid with a username, ,first_name, last_name, password, age, bio" do
    expect(user).to be_valid
  end

  it "is not valid without a password" do
    expect(User.new(username: "Name")).not_to be_valid
  end

  it "has many commented_remedies" do
    first_comment = Comment.create(:content => "it works!", :user_id => user.id, :remedy_id => corona_cure.id)
    second_comment = Comment.create(:content => "i love it!", :user_id => user.id, :remedy_id => indigestion_cure.id)
    expect(user.commented_remedies.first).to eq(corona_cure)
    expect(user.commented_remedies.last).to eq(indigestion_cure)
  end

  it "has many comments" do
    first_comment = Comment.create(:content => "it works!", :user_id => user.id, :remedy_id => corona_cure.id)
    second_comment = Comment.create(:content => "i love it!", :user_id => user.id, :remedy_id => indigestion_cure.id)
    expect(user.comments.first).to eq(first_comment)
    expect(user.comments.last).to eq(second_comment)
  end

  it "has many remedies" do
    new_user = User.create(:username => "winna", :first_name => "Harry", :last_name => "potter", :password => "password", :age => 40, :bio => "I like to code, play games, and magic.")
    new_remedy = Remedy.create(:user_id => new_user.id, :title => "tummy cure", :description => "Pepto Bismo")
    new_remedy2 = Remedy.create(:user_id => new_user.id, :title => "headache cure", :description => "ibs")
    expect(new_user.remedies.first).to eq(new_remedy)
    expect(new_user.remedies.last).to eq(new_remedy2)
  end

  it "can tell if a user is elderly" do
    expect(User.elderly).to eq(User.where("age >= 60"))
  end

end