require 'rails_helper'

RSpec.describe PeopleController do

  context "Creating person with contact details" do
    let(:hash) { { person: { first_name: "Bobby", last_name: 'Tables', contact_details_attributes: { email: "hello@administrate.com"  }}  }}

    it "Should create a person" do
      expect { post :create, hash}
      .to change(Person, :count).by(1)
    end

    it "Should create a contact details" do
      expect { post :create, hash }
      .to change(ContactDetails, :count).by(1)
    end

    it "the contact details should belong to the person" do
      post :create, hash
      expect( Person.last.contact_details.id )
        .to be(ContactDetails.last.id)
    end
  end

  context "When there is a person" do
    let!(:person) { Person.create(first_name: "Bobby", last_name: "Tables") }
    let(:alternative_first_name) { "Jimmy" }

    it "should be able to be destroyed" do
      expect { delete :destroy, id: person.id }
        .to change(Person, :count).by(-1)
    end

    it "should be update with update" do
      expect { put :update, id: person.id, person: { first_name: alternative_first_name } }
        .to change{ person.reload.first_name }.to(alternative_first_name)
    end
  end

  context "When there is a person in an organisation" do
    let(:person) { Person.create(first_name: "Bobby", last_name: "Tables") }
    let(:organisation) { Organisation.create(name: "Administrate") }
    let!(:membership) { Organisation::Membership.create(person: person, organisation: organisation) }
    let(:organisation2) { Organisation.create(name: "University") }

    it "should be destroyed when the person is destroyed" do
      expect { delete :destroy, id: person.id }
        .to change(Organisation::Membership, :count).by(-1)
    end

    it "should udpate membership with update" do
      expect { put :update, id: person.id, person: { membership_attributes: { organisation_id: organisation2.id } } }
        .to change{ person.membership(true).organisation_id }.from(organisation.id).to(organisation2.id)
    end

    it "should be removed when no organisation is chosen in update" do
      expect { put :update, id: person.id, person: { membership_attributes: { organisation_id: nil } } }
        .to change(Organisation::Membership, :count).by(-1)
    end
  end
end
