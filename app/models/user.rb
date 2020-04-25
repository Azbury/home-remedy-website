class User < ActiveRecord::Base
    has_secure_password
    has_many :remedies
    has_many :comments
    has_many :commented_remedies, :through => :comments, source: :remedy
    scope :elderly, -> { where("age >= 60") }
    validates :username, uniqueness: true
    validates :username, :first_name, :last_name, :age, :bio, presence: true
    validates :age, numericality: { greater_than: 0}
    validates :bio, length: { maximum: 500 }
end