# address-book


Organisation
- has_many :people
- has_one :contact_detail, 

Person
- has_one  :organisation
- has_one  :contact_detail, as: :contact
- has_many :emails

ContactDetails
- has_one :contact, polymorphic: true
