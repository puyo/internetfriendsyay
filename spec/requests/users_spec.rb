require 'rails_helper'

RSpec.describe "/users", type: :request do
  let(:valid_attributes) {
    { timezone: 'Australia/Sydney' }
  }

  let(:invalid_attributes) {
    { timezone: 'Australia/Foobar' }
  }

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { timezone: 'Australia/Perth' }
      }

      it "updates the requested user session" do
        patch user_url, params: { user: new_attributes, schedule_uuid: '123' }
        expect(session[:user]).to match({'timezone' => 'Australia/Perth'})
      end

      it "redirects to the schedule" do
        patch user_url, params: { user: new_attributes, schedule_uuid: '123' }
        expect(response).to redirect_to(schedule_url('123'))
      end
    end

    context "with no schedule uuid" do
      it "redirects to the root url" do
        patch user_url, params: { user: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end
  end
end

