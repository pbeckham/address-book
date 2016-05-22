require 'rails_helper'

RSpec.describe MembershipsController do

  context "When their is an organisation" do
    let(:organisation) { Organisation.create(name: "University") }
    let(:person) { Person.create(first_name: "Bobby", last_name: "Tables") }

    it "should allow a membership to be created" do
      expect { post :create, organisation_id: organisation.id, organisation_membership: { person_id: person.id }  }
      .to change(Organisation::Membership, :count).by(1)
    end

    context "When their is a person in the organisation" do
      before do
        organisation.people << person
      end

      it "should allow a membership to be deleted" do
        expect { delete :destroy, organisation_id: organisation.id, id: organisation.memberships.first.id  }
        .to change(Organisation::Membership, :count).by(-1)
      end

    end
  end
end
