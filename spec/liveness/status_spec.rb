# frozen_string_literal: true

RSpec.describe Liveness::Status do
  let(:config) { Liveness::Config.new }
  subject(:status) { described_class.new(Rack::MockRequest.env_for('/'), config: config) }

  describe '.call' do
    subject { described_class.call(Rack::MockRequest.env_for('/')) }

    it { is_expected.to include(200) }
    it { is_expected.to include({ 'Content-Type' => 'application/json' }) }
    it { is_expected.to include(['{}']) }

    context 'when protected by token' do
      before { Liveness.config.token = 'tew-htj_pca3GKQ6yxk' }
      after { Liveness.config.token = nil }

      it { is_expected.to include(403) }
      it { is_expected.to include([include('invalid token')]) }
    end
  end

  describe '#live?' do
    it { is_expected.to be_live }

    context 'when dependency configured and available' do
      before do
        config.add(:postgres) { true }
      end

      it { is_expected.to be_live }
    end

    context 'when dependency not available' do
      before do
        config.add(:postgres) { false }
      end

      it { is_expected.not_to be_live }
    end
  end

  describe '#token_valid?' do
    before do
      config.token = 'tew-htj_pca3GKQ6yxk'
    end

    it { is_expected.not_to be_valid_token }

    context 'when token given' do
      subject(:status) { described_class.new(Rack::MockRequest.env_for('/?token=tew-htj_pca3GKQ6yxk'), config: config) }

      it { is_expected.to be_valid_token }
    end
  end

  describe '#metrics' do
    subject { status.metrics }
    it { is_expected.to be_empty }
  end
end
