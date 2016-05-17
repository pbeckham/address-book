class ContactDetails < ActiveRecord::Base
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/

  belongs_to :contactable, polymorphic: true

  validates :email, format: EMAIL_REGEX
end
