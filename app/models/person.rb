class Person < ActiveRecord::Base
  has_one :membership,  class_name: 'Organisation::Membership', dependent: :destroy
  has_one :organisation, through: :membership

  has_one :contact_details, as: :contactable, dependent: :destroy

  accepts_nested_attributes_for :contact_details
  accepts_nested_attributes_for :membership

  def full_name
    [first_name, last_name].join(" ")
  end

  def contact_details *args
    super(*args) || build_contact_details
  end

  def membership *args
    super(*args) || build_membership
  end
end
