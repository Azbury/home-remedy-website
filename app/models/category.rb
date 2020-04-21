class Category < ActiveRecord::Base
    has_many :remedy_categories
    has_many :remedies, :through => :remedy_categories
    validates :name, uniqueness: true
    validates :name, presence: true
end