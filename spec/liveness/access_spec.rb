# frozen_string_literal: true

RSpec.describe Liveness::Access do
  let(:config) { Liveness::Config.new }
  let(:env) { Rack::MockRequest.env_for('/') }
  subject(:access) { described_class.new(Rack::Request.new(env), config: config) }

  it { is_expected.to be_allowed }

  describe '#valid_token?' do
    before { config.token = 'PJR@vey8cwe1xth0qvc' }

    it { is_expected.not_to be_allowed }

    context 'when token given in request' do
      let(:env) { Rack::MockRequest.env_for('/?token=PJR@vey8cwe1xth0qvc') }

      it { is_expected.to be_allowed }
    end
  end
end
