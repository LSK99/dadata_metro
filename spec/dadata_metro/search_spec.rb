require "dadata_metro/constants"
require 'webmock/rspec'

RSpec.describe DadataMetro::Search do

  subject(:metro_search) { described_class.new(api_token: api_token).call(params) }

  let(:api_token) { 'test' }
  let(:params) { nil }

  describe "raise exception on incorrect params" do
    
    context 'without api_token' do
      let(:api_token) { nil }

      it { expect { metro_search }.to raise_error(ArgumentError) }
    end

    context 'without query' do
      it { expect { metro_search }.to raise_error(ArgumentError) }
    end

    context 'with nil query' do
      let(:params) { { query: nil } }

      it { expect { metro_search }.to raise_error(ArgumentError) }
    end

    context 'with too long query' do
      let(:params) { { query: "test" * 100 } }

      it { expect { metro_search }.to raise_error(ArgumentError) }
    end

    context 'with filters not array' do
      let(:params) { { query: "test", filters: "test" } }

      it { expect { metro_search }.to raise_error(ArgumentError) }
    end

    context 'with filters not supported' do
      let(:params) { { query: "test", filters: [{ not_supported_field: "test" }] } }

      it { expect { metro_search }.to raise_error(ArgumentError) }
    end
  end

  describe 'with correct params' do

    before do
      stub_request(:post, URI(DadataMetro::Constants::BASE_URL)).
        to_return(status: 200, body: { "test" => "test" }.to_json, headers: {})
    end

    context 'with filters not supported' do
      let(:params) { { query: "test" } }

      it do
        expect(metro_search).to eq({ "test" => "test" })
      end
    end
  end
end
