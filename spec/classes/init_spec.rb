require 'spec_helper'

describe 'inifile' do
  describe 'with parameter hiera_merge' do
    context 'as an invalid type (non-string and a non-boolean)' do
      it 'should fail' do
        expect {
          should raise_error(Puppet::Error)
        }
      end
    end
    ['true',true,'false',false].each do |value|
      context "set to #{value}" do

        it { should compile.with_all_deps }

        it 'should not fail' do
          expect {
            should_not raise_error(Puppet::Error)
          }
        end
      end
    end
  end
end
