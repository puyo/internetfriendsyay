require 'rails_helper'

describe UsersController do
  let(:user) { double('user', timezone: 'Fishbuckland') }
  describe '#update' do
    let(:request_params) { { user: { timezone: 'foobar' } } }
    before do
      allow(User).to receive(:new).and_return(user)
    end
    before do
      put :update, request_params
    end
    describe 'flash.notice' do
      specify { expect(flash.notice).to be_present }
    end
    describe 'session' do
      specify { expect(session[:user]).to eq(user) }
    end
    describe 'response' do
      subject { response }
      context 'with schedule_uuid == "23"' do
        let(:request_params) { { schedule_uuid: 'abc23' } }
        it { is_expected.to redirect_to '/schedules/abc23' }
      end
      context 'without return_to param' do
        it { is_expected.to redirect_to '/' }
      end
    end
  end
end
