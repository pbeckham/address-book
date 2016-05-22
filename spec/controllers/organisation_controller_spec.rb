require 'rails_helper'

RSpec.describe OrganisationsController do

  context "Creating organisations with contact details" do
    let(:organisation_hash) { { organisation: { name: "Administrate", contact_details_attributes: { email: "hello@administrate.com"  }}  }}

    it "Should create an organisation" do
      expect { post :create, organisation_hash }
        .to change(Organisation, :count).by(1)
    end

    it "Should create a contact details" do
      expect { post :create, organisation_hash }
        .to change(ContactDetails, :count).by(1)
    end

    it "the contact details should belong to the organisation" do
      post :create, organisation_hash
      expect( Organisation.last.contact_details.id )
        .to be(ContactDetails.last.id)
    end
  end

  context "When there is an organisation" do
    let!(:organisation) { Organisation.create(name: "Test") }
    let(:alternative_name) { "Test2" }

    it "should be able to be destroyed" do
      expect { delete :destroy, id: organisation.id }
        .to change(Organisation, :count).by(-1)
    end

    it "should be update with update" do
      expect { put :update, id: organisation.id, organisation: { name: alternative_name } }
        .to change{ organisation.reload.name }.to(alternative_name)
    end
  end
end
