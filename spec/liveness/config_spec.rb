# frozen_string_literal: true

RSpec.describe Liveness::Config do
  subject(:container) { Liveness::Container.new }
  subject(:config) { described_class.new(container: container) }

  describe '#add' do
    subject(:add_dependency) { config.add :redis }

    it do
      add_dependency
      expect(config.dependencies).to be_empty
    end

    context 'when dependnecy defined' do
      before do
        container.register :redis, Liveness::Dependency
      end

      it do
        add_dependency
        expect(config.dependencies).not_to be_empty
      end
    end
  end
end
