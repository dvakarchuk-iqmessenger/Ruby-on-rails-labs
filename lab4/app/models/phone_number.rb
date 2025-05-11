class PhoneNumber < ApplicationRecord
  belongs_to :contact

  validates :number, presence: true, format: { with: /\A\+?\d{9,15}\z/, message: "має бути у форматі +380..." }
end
