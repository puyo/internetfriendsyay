 require 'rails_helper'

RSpec.describe "/people", type: :request do
  let(:valid_attributes) {
    {
      name: 'Fishbuck',
      timezone: 'Australia/Sydney',
    }
  }

  let(:invalid_attributes) {
    {
      name: '',
      timezone: 'Sydney',
    }
  }

  let!(:schedule) { Schedule.first_or_create!(uuid: 'c2e131ac1fb6d8e0f85123168c800369') }

  describe "GET /new" do
    it "renders a successful response" do
      get new_schedule_person_url(schedule)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      person = schedule.people.create! valid_attributes
      get edit_schedule_person_url(schedule, person)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new person" do
        expect {
          post schedule_people_url(schedule), params: { person: valid_attributes }
        }.to change(Person, :count).by(1)
      end

      it "redirects to the schedule" do
        post schedule_people_url(schedule), params: { person: valid_attributes }
        expect(response).to redirect_to(schedule_url(schedule))
      end
    end

    context "with invalid parameters" do
      it "does not create a new person" do
        expect {
          post schedule_people_url(schedule), params: { person: invalid_attributes }
        }.to change(Person, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post schedule_people_url(schedule), params: { person: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: 'Buckfish',
        }
      }

      it "updates the requested person" do
        person = schedule.people.create! valid_attributes
        patch schedule_person_url(schedule, person), params: { person: new_attributes }
        person.reload
        expect(person.name).to eq('Buckfish')
      end

      it "redirects to the schedule" do
        person = schedule.people.create! valid_attributes
        patch schedule_person_url(schedule, person), params: { person: new_attributes }
        person.reload
        expect(response).to redirect_to(schedule_url(schedule))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        person = schedule.people.create! valid_attributes
        patch schedule_person_url(schedule, person), params: { person: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested person" do
      person = schedule.people.create! valid_attributes
      expect {
        delete schedule_person_url(schedule, person)
      }.to change(Person, :count).by(-1)
    end

    context "with two people" do
      it "redirects to the schedule" do
        person = schedule.people.create!(name: 'Fishbuck1', timezone: 'Australia/Sydney')
        schedule.people.create!(name: 'Fishbuck2', timezone: 'Australia/Perth')
        delete schedule_person_url(schedule, person)
        expect(response).to redirect_to(schedule_url(schedule))
      end
    end

    context "with one person" do
      it "redirects to the root" do
        person = schedule.people.create! valid_attributes
        delete schedule_person_url(schedule, person)
        expect(response).to redirect_to(root_url)
      end
    end
  end
end

