class Person < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  belongs_to :organisation, through: :memberships

  has_one :contact_details, as: :contactable
end
