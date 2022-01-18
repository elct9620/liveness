# frozen_string_literal: true

RSpec.describe Liveness do
  it 'has a version number' do
    expect(Liveness::VERSION).not_to be nil
  end

  describe '.config' do
    subject { described_class.config }

    it { is_expected.to be_a(Liveness::Config) }
  end

  describe '.container' do
    subject { described_class.container }

    it { is_expected.to be_a(Liveness::Container) }
  end
end
