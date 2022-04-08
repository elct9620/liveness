# frozen_string_literal: true

RSpec.describe Liveness::Status do
  let(:config) { Liveness::Config.new }
  subject(:status) { described_class.new(Rack::MockRequest.env_for('/'), config: config) }

  describe '.call' do
    subject { described_class.call(Rack::MockRequest.env_for('/')) }

    it { is_expected.to be_a(Array) }
    it { is_expected.to include(200) }
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

  describe '#metrics' do
    subject { status.metrics }
    it { is_expected.to be_empty }
  end
end
