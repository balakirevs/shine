require 'rails_helper'

describe FakeBillingController do
  describe "#show" do
    context "json" do
      context "with cardholder_id" do
        before do
          get :show, cardholder_id: "234234234"
          @parsed_response = JSON.parse(response.body)
        end
        specify { expect(@parsed_response["lastFour"]).to_not eq(nil) }
        specify { expect(@parsed_response["cardType"]).to_not eq(nil) }
        specify { expect(@parsed_response["expirationMonth"]).to_not eq(nil) }
        specify { expect(@parsed_response["expirationYear"]).to_not eq(nil) }
        specify { expect(@parsed_response["detailsLink"]).to_not eq(nil) }
      end
      context "without cardholder_id" do
        before do
          get :show
        end
        specify { expect(response.code).to eq("404") }
      end
    end
  end
end