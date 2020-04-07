class RemedyCategory < ActiveRecord::Base
    belongs_to :remedy
    belongs_to :category
  end
  