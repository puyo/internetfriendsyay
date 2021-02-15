require 'rails_helper'

RSpec.describe "/schedules", type: :request do
  let(:valid_attributes_model) {
    {
      people_attributes: {"0"=>{"name"=>"Fuuu", "timezone"=>"Australia/Perth", "available_at"=>["144"]}}
    }
  }
  let(:valid_attributes_controller) {
    {
      people_attributes: {"0"=>{"name"=>"Fuuu", "timezone"=>"Australia/Perth", "available_at"=>{"144"=>{}}}}
    }
  }

  let(:invalid_attributes) {
    {
      people_attributes: {"0"=>{"name"=>"", "timezone"=>"Perth"}}
    }
  }

  describe "GET /show" do
    it "renders a successful response" do
      schedule = Schedule.create!(valid_attributes_model)
      get schedule_url(schedule)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_schedule_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new schedule" do
        expect {
          post schedules_url, params: { schedule: valid_attributes_controller }
        }.to change(Schedule, :count).by(1)
      end

      it "redirects to the schedule" do
        post schedules_url, params: { schedule: valid_attributes_controller }
        expect(response).to redirect_to(schedule_url(Schedule.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new schedule" do
        expect {
          post schedules_url, params: { schedule: invalid_attributes }
        }.to change(Schedule, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post schedules_url, params: { schedule: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end

