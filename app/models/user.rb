class User < ActiveRecord::Base
    has_secure_password
    has_many :remedies
    has_many :comments
    has_many :commented_remedies, :through => :comments, source: :remedy
    scope :elderly, -> { where("age >= 60") }
end