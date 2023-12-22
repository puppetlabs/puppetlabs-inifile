# frozen_string_literal: true

require 'spec_helper'
# We can't really test much here, apart from the type roundtrips though the
# parser OK.
describe 'inherit_test1' do
  it {
    expect(subject).to contain_inherit_ini_setting('valid_type').with('value' => 'true')
  }
end
