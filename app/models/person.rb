class Person < ActiveRecord::Base
  has_many :memberships, class_name: 'Organisation::Membership', dependent: :destroy
  has_one :organisation, through: :memberships

  has_one :contact_details, as: :contactable, dependent: :destroy

  accepts_nested_attributes_for :contact_details

  def full_name
    [first_name, last_name].join(" ")
  end
end
