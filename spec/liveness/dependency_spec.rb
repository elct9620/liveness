# frozen_string_literal: true

RSpec.describe Liveness::Dependency do
  subject(:dependency) { described_class.new }

  describe '#name' do
    let(:dependency) { described_class.new(name: 'primary_database') }
    subject { dependency.name }

    it { is_expected.to eq('primary_database') }
  end

  describe '#status' do
    subject { dependency.status }

    before do
      allow(dependency).to receive(:check!).and_return(false)
    end

    it { is_expected.to include(status: 'failed') }

    context 'when dependency alive' do
      before do
        allow(dependency).to receive(:check!).and_return(true)
      end

      it { is_expected.to include(status: 'ok') }
    end
  end

  describe '#alive?' do
    subject { dependency.alive? }

    before do
      allow(dependency).to receive(:check!).and_return(false)
    end

    it { is_expected.to be_falsy }

    context 'when dependency alive' do
      before do
        allow(dependency).to receive(:check!).and_return(true)
      end

      it { is_expected.to be_truthy }
    end

    context 'when timeout' do
      before do
        allow(dependency).to receive(:check!).and_raise(Timeout::Error)
      end

      it { is_expected.to be_falsy }
    end
  end

  describe '#check!' do
    subject(:check!) { dependency.check! }

    it { expect { check! }.to raise_error(NotImplementedError) }
  end
end
