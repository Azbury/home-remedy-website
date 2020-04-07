class Comment < ActiveRecord::Base
    belongs_to :remedy
    belongs_to :user
end