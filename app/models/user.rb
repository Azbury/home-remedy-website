class User < ActiveRecord::Base
    has_secure_password
    has_many :remedies
    has_many :comments
    has_many :commented_remedies, :through => :comments, source: :remedy
    scope :elderly, -> { where("age >= 60") }
    validates :username, uniqueness: true
    validates :username, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :age, presence: true
    validates :bio, presence: true
    validates :bio, length: { maximum: 500 }
end