class Note < ApplicationRecord
  belongs_to :script
  belongs_to :user
end
