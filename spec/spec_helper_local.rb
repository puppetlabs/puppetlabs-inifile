# frozen_string_literal: true

if ENV['COVERAGE'] == 'yes'
  require 'simplecov'
  require 'simplecov-console'
  require 'codecov'

  SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console,
    SimpleCov::Formatter::Codecov,
  ]
  SimpleCov.start do
    track_files 'lib/**/*.rb'

    add_filter '/spec'

    # do not track vendored files
    add_filter '/vendor'
    add_filter '/.vendor'

    # do not track gitignored files
    # this adds about 4 seconds to the coverage check
    # this could definitely be optimized
    add_filter do |f|
      # system returns true if exit status is 0, which with git-check-ignore means file is ignored
      system("git check-ignore --quiet #{f.filename}")
    end
  end
end

shared_examples 'create_ini_settings function' do
  it { is_expected.not_to eq(nil) }
  it { is_expected.to run.with_params({}) }
  it { is_expected.to run.with_params({}, {}) }

  it { is_expected.to run.with_params('section' => { 'setting' => 'value' }).and_raise_error(Puppet::ParseError, %r{must pass the path parameter}) }
  it { is_expected.to run.with_params(1 => 2).and_raise_error(Puppet::ParseError, %r{Section 1 must contain a Hash}) }
end
