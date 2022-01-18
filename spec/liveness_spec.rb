# frozen_string_literal: true

RSpec.describe Liveness do
  it 'has a version number' do
    expect(Liveness::VERSION).not_to be nil
  end
end
