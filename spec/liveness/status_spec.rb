# frozen_string_literal: true

RSpec.describe Liveness::Status do
  subject(:status) { described_class.new(Rack::MockRequest.env_for('/')) }

  describe '.call' do
    subject { described_class.call(Rack::MockRequest.env_for('/')) }

    it { is_expected.to be_a(Array) }
  end

  describe '#live?' do
    it { is_expected.to be_live }
  end

  describe '#metrics' do
    subject { status.metrics }
    it { is_expected.to be_empty }
  end
end
