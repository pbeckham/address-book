class Organisation < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :people, through: :memberships

  has_one :contact_details, as: :contactable, dependent: :destroy

  accepts_nested_attributes_for :contact_details
end
