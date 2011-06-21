require 'spec_helper'

describe UserController do
  let(:user) { mock('user', timezone: 'Fishbuckland') }

  describe '#update' do
    let(:request_params) { { user: {timezone: 'foobar'} } }
    before do
      User.stub(:new).and_return(user)
    end
    before do
      put :update, request_params
    end
    describe 'flash.notice' do
      specify { flash.notice.should be_present }
    end
    describe 'session' do
      specify { session[:user].should == user }
    end
    describe 'response' do
      subject { response }
      context 'with return_to == "/return_to"' do
        let(:request_params) { { return_to: '/return_to' } }
        it { should redirect_to '/return_to' }
      end
      context 'without return_to param' do
        it { should redirect_to '/' }
      end
    end
  end
end
