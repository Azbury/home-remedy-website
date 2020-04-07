class Remedy < ActiveRecord::Base
    belongs_to :user
    has_many :categorys
    belongs_to :category
end