class User < ApplicationRecord
  has_many :scripts
  has_many :notes
end