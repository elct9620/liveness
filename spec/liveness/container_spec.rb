# frozen_string_literal: true

RSpec.describe Liveness::Container do
  subject(:container) { described_class.new }

  describe '#create' do
    subject { container.create(:redis) }

    it { is_expected.to be_nil }

    context 'when provider be found' do
      before { container.register(:redis, Liveness::Dependency) }

      it { is_expected.to be_a(Object) }
    end
  end
end
