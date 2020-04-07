class Remedy < ActiveRecord::Base
    belongs_to :user
    has_many :users, :through => :comments
    has_many :remedy_categories
    has_many :categories, :through => :remedy_categories
end