class Person < ApplicationRecord
    has_many :animals, foreign_key: 'owner_id'
  end
  