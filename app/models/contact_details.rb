class ContactDetails < ActiveRecord::Base
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/
  ALLOWED_ATTRIBUTES = %i( email telephone address_line_1 address_line_2 address_line_3 city postal_code country_code)

  belongs_to :contactable, polymorphic: true

  validates :email, format: EMAIL_REGEX, allow_blank: true
end
