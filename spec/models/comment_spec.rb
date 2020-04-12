require 'rails_helper'

RSpec.describe Comment, :type => :model do
  let(:remedy) {
    Remedy.create(
        :user_id => user.id,
        :title => "Juice Cleanse",
        :description => "drink that juice, get healthy."
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

  it "is valid with content, a user_id, and a remedy_id" do
    expect(comment).to be_valid
  end

  it "belongs to one remedy" do
    expect(comment.remedy).to eq(remedy)
  end

  it "belongs to one user" do
    expect(comment.user).to eq(user)
  end

end