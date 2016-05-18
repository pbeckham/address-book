require "rails_helper"

RSpec.describe Organisation do

  context "When you have an organisation with memberships and contact details" do
    let(:person) { Person.create(first_name: "Baby", last_name: "Bear") }
    let(:organisation) { Organisation.create(name: "Bear family") }
    let(:contact_details) { ContactDetails.create(email: "bear@bigwoods.com") }

    before do
      organisation.people << person
      organisation.contact_details = contact_details
      organisation.save
    end

    it "delete memberships when destroyed" do
      expect{ 
        organisation.destroy 
      }.to change{ Organisation::Membership.count }.by(-1)
    end

    it "delete contact details when destroyed" do
      expect{ 
        organisation.destroy 
      }.to change{ ContactDetails.count }.by(-1)
    end

    it "not delete people when destroyed" do
      expect{ 
        organisation.destroy 
      }.to_not change{ Person.count }
    end
  end

end
