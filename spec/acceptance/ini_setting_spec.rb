require 'spec_helper_acceptance'

tmpdir = default.tmpdir('tmp')

describe 'ini_setting resource' do
  after :all do
    shell("rm #{tmpdir}/*.ini", acceptable_exit_codes: [0, 1, 2])
  end

  shared_examples 'has_content' do |path, pp, content|
    before :all do
      shell("rm #{path}", acceptable_exit_codes: [0, 1, 2])
    end

    it 'applies the manifest twice' do
      idempotent_apply(default, pp, {})
    end

    describe file(path) do
      it { is_expected.to be_file }

      describe '#content' do
        subject { super().content }

        it { is_expected.to match content }
      end
    end
  end

  shared_examples 'has_error' do |path, pp, error|
    before :all do
      shell("rm #{path}", acceptable_exit_codes: [0, 1, 2])
    end

    it 'applies the manifest and gets a failure message' do
      expect(apply_manifest(pp, expect_failures: true).stderr).to match(error)
    end

    describe file(path) do
      it { is_expected.not_to be_file }
    end
  end

  context 'ensure parameter => present for global and section' do
    pp = <<-EOS
    ini_setting { 'ensure => present for section':
      ensure  => present,
      path    => "#{tmpdir}/ini_setting.ini",
      section => 'one',
      setting => 'two',
      value   => 'three',
    }
    ini_setting { 'ensure => present for global':
      ensure  => present,
      path    => "#{tmpdir}/ini_setting.ini",
      section => '',
      setting => 'four',
      value   => 'five',
    }
    EOS

    it_behaves_like 'has_content', "#{tmpdir}/ini_setting.ini", pp, %r{four = five\n\n\[one\]\ntwo = three}
  end

  context 'ensure parameter => absent for key/value' do
    before :all do
      ini = <<-EOS
        four = five
        [one]
        two = three
        EOS
      create_remote_file(default, File.join(tmpdir, 'ini_setting.ini'), ini)
    end

    pp = <<-EOS
    ini_setting { 'ensure => absent for key/value':
      ensure  => absent,
      path    => "#{tmpdir}/ini_setting.ini",
      section => 'one',
      setting => 'two',
      value   => 'three',
    }
    EOS

    it 'applies the manifest twice' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe file("#{tmpdir}/ini_setting.ini") do
      it { is_expected.to be_file }

      describe '#content' do
        subject { super().content }

        it { is_expected.to match %r{four = five} }
        it { is_expected.not_to match %r{\[one\]} }
        it { is_expected.not_to match %r{two = three} }
      end
    end
  end

  context 'ensure parameter => absent for global' do
    before :all do
      ini = <<-EOS
        four = five
        [one]
        two = three
        EOS
      create_remote_file(default, File.join(tmpdir, 'ini_setting.ini'), ini)
    end
    after :all do
      shell("rm #{tmpdir}/ini_setting.ini", acceptable_exit_codes: [0, 1, 2])
    end

    pp = <<-EOS
    ini_setting { 'ensure => absent for global':
      ensure  => absent,
      path    => "#{tmpdir}/ini_setting.ini",
      section => '',
      setting => 'four',
      value   => 'five',
    }
    EOS

    it 'applies the manifest twice' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe file("#{tmpdir}/ini_setting.ini") do
      it { is_expected.to be_file }

      describe '#content' do
        subject { super().content }

        it { is_expected.not_to match %r{four = five} }
        it { is_expected.to match %r{\[one\]} }
        it { is_expected.to match %r{two = three} }
      end
    end
  end

  describe 'path parameter' do
    context 'path => foo' do
      pp = <<-EOS
        ini_setting { 'path => foo':
          ensure     => present,
          section    => 'one',
          setting    => 'two',
          value      => 'three',
          path       => 'foo',
        }
      EOS

      it_behaves_like 'has_error', 'foo', pp, %r{must be fully qualified}
    end
  end

  describe 'show_diff parameter and logging:' do
    [{ value: 'initial_value', matcher: 'created', show_diff: true },
     { value: 'public_value', matcher: %r{initial_value.*public_value}, show_diff: true },
     { value: 'secret_value', matcher: %r{redacted sensitive information.*redacted sensitive information}, show_diff: false },
     { value: 'md5_value', matcher: %r{\{md5\}881671aa2bbc680bc530c4353125052b.*\{md5\}ed0903a7fa5de7886ca1a7a9ad06cf51}, show_diff: :md5 }].each do |i|

      pp = <<-EOS
          ini_setting { 'test_show_diff':
            ensure      => present,
            section     => 'test',
            setting     => 'something',
            value       => '#{i[:value]}',
            path        => "#{tmpdir}/test_show_diff.ini",
            show_diff   => #{i[:show_diff]}
          }
      EOS

      context "show_diff => #{i[:show_diff]}" do
        config = { 'main' => { 'show_diff' => true } }
        configure_puppet_on(default, config)

        res = apply_manifest(pp, expect_changes: true)
        it 'applies manifest and expects changed value to be logged in proper form' do
          expect(res.stdout).to match(i[:matcher])
        end
        it 'applies manifest and expects changed value to be logged in proper form #optional test' do
          expect(res.stdout).not_to match(i[:value]) unless i[:show_diff] == true
        end
      end
    end
  end

  describe 'values with spaces in the value part at the beginning or at the end' do
    pp = <<-EOS
      ini_setting { 'path => foo':
          ensure     => present,
          section    => 'one',
          setting    => 'two',
          value      => '               123',
          path       => '#{tmpdir}/ini_setting.ini',
        }
    EOS

    it_behaves_like 'has_content', "#{tmpdir}/ini_setting.ini", pp, %r{\[one\]\ntwo = 123}
  end

  describe 'refreshonly' do
    path = File.join(tmpdir, 'test.txt')
    before :each do
      shell("echo \"[section1]\nvalueinsection1 = 123\" > #{path}")
    end
    after :each do
      shell("rm #{path}", acceptable_exit_codes: [0, 1, 2])
    end
    context 'when event is triggered' do
      context 'update setting value' do
        let(:update_value_manifest) do
          <<-EOS
          notify { foo:
            notify => Ini_Setting['updateSetting'],
          }

          ini_setting { "updateSetting":
            ensure => present,
            path => "#{path}",
            section => 'section1',
            setting => 'valueinsection1',
            value   => "newValue",
            refreshonly => true,
          }
          EOS
        end

        before(:each) do
          apply_manifest(update_value_manifest, expect_changes: true)
        end

        describe file(path) do
          it { is_expected.to be_file }
          describe '#content' do
            subject { super().content }

            it { is_expected.to match %r{valueinsection1 = newValue} }
          end
        end
      end

      context 'remove setting value' do
        let(:remove_setting_manifest) do
          <<-EOS
          notify { foo:
            notify => Ini_Setting['removeSetting'],
          }

          ini_setting { "removeSetting":
            ensure => absent,
            path => "#{path}",
            section => 'section1',
            setting => 'valueinsection1',
            refreshonly => true,
          }
          EOS
        end

        before(:each) do
          apply_manifest(remove_setting_manifest, expect_changes: true)
        end

        describe file(path) do
          it { is_expected.to be_file }
          describe '#content' do
            subject { super().content }

            it { is_expected.to be_empty }
          end
        end
      end
    end

    context 'when not receiving an event' do
      context 'does not update setting' do
        let(:does_not_update_value_manifest) do
          <<-EOS
          file { "#{path}":
            ensure => present,
            notify => Ini_Setting['updateSetting'],
          }

          ini_setting { "updateSetting":
            ensure => present,
            path => "#{path}",
            section => 'section1',
            setting => 'valueinsection1',
            value   => "newValue",
            refreshonly => true,
          }
          EOS
        end

        before(:each) do
          apply_manifest(does_not_update_value_manifest, expect_changes: false)
        end

        describe file(path) do
          it { is_expected.to be_file }
          describe '#content' do
            subject { super().content }

            it { is_expected.to match %r{valueinsection1 = 123} }
            it { is_expected.to match %r{\[section1\]} }
          end
        end
      end

      context 'does not remove setting' do
        let(:does_not_remove_setting_manifest) do
          <<-EOS
          file { "#{path}":
            ensure => present,
            notify => Ini_Setting['removeSetting'],
          }

          ini_setting { "removeSetting":
            ensure => absent,
            path => "#{path}",
            section => 'section1',
            setting => 'valueinsection1',
            refreshonly => true,
          }
          EOS
        end

        before(:each) do
          apply_manifest(does_not_remove_setting_manifest, expect_changes: false)
        end

        describe file(path) do
          it { is_expected.to be_file }
          describe '#content' do
            subject { super().content }

            it { is_expected.not_to be_empty }
            it { is_expected.to match %r{valueinsection1 = 123} }
            it { is_expected.to match %r{\[section1\]} }
          end
        end
      end
    end
  end
end
