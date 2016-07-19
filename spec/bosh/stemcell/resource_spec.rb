require 'spec_helper'

describe Bosh::Stemcell::Resource do
  it 'has a version number' do
    expect(Bosh::Stemcell::Resource::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
