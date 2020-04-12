require 'rails_helper'

RSpec.describe Remedy, :type => :model do

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

  let(:remedy) {
    Remedy.create(
        :user_id => user.id,
        :title => "Juice Cleanse",
        :description => "drink that juice, get healthy."
    )
  }

  it "is valid with a title, user_id, and description" do
    expect(remedy).to be_valid
  end

  it "belongs to a user" do
    expect(remedy.user).to eq(user)
  end

  it "has many comments" do
    first_comment = Comment.create(:content => "it works!", :user_id => user.id, :remedy_id => remedy.id)
    second_comment = Comment.create(:content => "i love it!", :user_id => user2.id, :remedy_id => remedy.id)
    expect(remedy.comments.first).to eq(first_comment)
    expect(remedy.comments.last).to eq(second_comment)
  end

  it "has many users through comments" do
    first_comment = Comment.create(:content => "it works!", :user_id => user.id, :remedy_id => remedy.id)
    second_comment = Comment.create(:content => "i love it!", :user_id => user2.id, :remedy_id => remedy.id)
    expect(remedy.users.first).to eq(user)
    expect(remedy.users.last).to eq(user2)
  end

  it "has many categories" do
    organic = Category.create(:name => "Organic")
    healthy = Category.create(:name => "Healthy")
    remedy.categories << [organic, healthy]
    expect(remedy.categories.first).to eq(organic)
    expect(remedy.categories.last).to eq(healthy)
  end
  
end