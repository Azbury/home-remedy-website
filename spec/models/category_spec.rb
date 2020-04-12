require 'rails_helper'

RSpec.describe Category, :type => :model do
  let(:remedy) {
    Remedy.create(
        :user_id => user.id,
        :title => "Juice Cleanse",
        :description => "drink that juice, get healthy."
    )
  }

  let(:corona_cure) {
    Remedy.create(
        :user_id => user.id,
        :title => "Cure for Corona",
        :description => "Do a dance, make a little, get down tonight."
    )
  }

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

  let(:comment) {
    Comment.create(:content => "looks cool", user_id: user.id, remedy_id: remedy.id)
  }

  let(:category) {
    Category.create(:name => "Organic")
  }

  it "is valid with a name" do
    expect(category).to be_valid
  end

  it "has many remedies" do
    category.remedies << [remedy, corona_cure]
    expect(category.remedies.first).to eq(remedy)
    expect(category.remedies.last).to eq(corona_cure)
  end

end