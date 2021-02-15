require 'rails_helper'
require 'geocoder/results/ipinfo_io'

RSpec.describe TimeZoneOptionsHelper, type: :helper do
  describe '#time_zone_options' do
    let(:results) {
      [
        Geocoder::Result::IpinfoIo.new(
          {
            "ip"=>"172.56.21.89",
            "city"=>"Nashville",
            "region"=>"Tennessee",
            "country"=>"US",
            "loc"=>"36.1659,-86.7844",
            "postal"=>"37219",
            "timezone"=>"America/Chicago",
            "readme"=>"https://ipinfo.io/missingauth"
          }
        )
      ]
    }

    before do
      allow(Geocoder).to receive(:search).and_return(results)
    end

    it 'should return {} with a blank ip' do
      expect(helper.time_zone_options(nil, '')).to eq({})
    end

    it 'should return {} with 127.0.0.1' do
      expect(helper.time_zone_options(nil, '127.0.0.1')).to eq({})
    end

    it 'should return a default value' do
      expect(helper.time_zone_options(nil, '172.56.21.89')[:default]).to eq("Central Time (US & Canada)")
    end

    context 'with unrecognised results' do
      let(:results) {
        [
          Geocoder::Result::IpinfoIo.new(
            {
              "ip"=>"172.56.21.89",
              "city"=>"Nashville",
              "region"=>"Tennessee",
              "country"=>"US",
              "loc"=>"36.1659,-86.7844",
              "postal"=>"37219",
              "timezone"=>"Unrecognised/City",
              "readme"=>"https://ipinfo.io/missingauth"
            }
          )
        ]
      }

      it 'should return some info for the priority setting' do
        expect(helper.time_zone_options(nil, '172.56.21.89')).to eq(priority: /Nashville|Tennessee|Unrecognised|City/)
      end
    end

    context 'with no results' do
      let(:results) { [] }

      it 'should return {}' do
        expect(helper.time_zone_options(nil, '172.56.21.89')).to eq({})
      end
    end

    context 'when an error is raised' do
      before do
        allow(Geocoder).to receive(:search).and_raise(RuntimeError.new('uh oh'))
      end

      it 'should return {}' do
        expect(helper.time_zone_options(nil, '172.56.21.89')).to eq({})
      end
    end

    context 'with an existing timezone' do
      let(:results) { [] }

      it 'should return {}' do
        opts = helper.time_zone_options('Australia/Sydney', '')
        expect(opts[:priority].map(&:to_s)).to eq(['(GMT+08:00) Perth',
                                                   '(GMT+09:30) Adelaide',
                                                   '(GMT+09:30) Darwin',
                                                   '(GMT+10:00) Brisbane',
                                                   '(GMT+10:00) Canberra',
                                                   '(GMT+10:00) Hobart',
                                                   '(GMT+10:00) Melbourne',
                                                   '(GMT+10:00) Sydney'])
      end
    end
  end
end
