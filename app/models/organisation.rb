class Organisation < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :people, through: :memberships

  has_one :contact_details, as: :contactable, dependent: :destroy

  accepts_nested_attributes_for :contact_details
  
  validates :name, presence: true

  def contact_details
    super || build_contact_details
  end
end
