class Memory < ApplicationRecord
  belongs_to :event
  has_many_attached :photos
end
