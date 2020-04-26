class Remedy < ActiveRecord::Base
    belongs_to :user
    has_many :comments
    has_many :users, :through => :comments
    has_many :remedy_categories
    has_many :categories, :through => :remedy_categories
    validates :title, :description, presence: true
    validates :title, uniqueness: true
end