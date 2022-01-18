# frozen_string_literal: true

RSpec.describe Liveness::Dependency do
  subject(:dependency) { described_class.new }

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
  end

  describe '#check!' do
    subject(:check!) { dependency.check! }

    it { expect { check! }.to raise_error(NotImplementedError) }
  end
end
