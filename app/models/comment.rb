class Comment < ActiveRecord::Base
    belongs_to :remedy
    belongs_to :user
    validates :content, presence: true
    validates :content, length: { maximum: 500 }
end