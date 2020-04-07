class Category < ActiveRecord::Base
    has_many :remedy_categories
    has_many :remedies, :through => :remedy_categories
end