class User < ApplicationRecord
  include Clearance::User

  has_many :scripts
  has_many :notes
end
