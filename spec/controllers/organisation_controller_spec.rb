require 'rails_helper'

RSpec.describe Api::OrganisationsController do

  let(:organisation_hash) { { organisation: { name: "Administrate" }}  }

  it "Should create organisations" do
    expect { post :create, organisation_hash }
     .to change { Organisation.count }.by(1)
  end
end
