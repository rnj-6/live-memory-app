class LiveLog < ApplicationRecord
  belongs_to :live_event
  has_many_attached :photos
end
