require 'spec_helper'

describe 'loader' do
  let(:pre_condition) {[
    'class my_class1() {}',
    'class my_class2() {}',
    'class my_class3() {}',
    'class my_class4() {}',
  ]}
  let(:validation_params) {{
    'hiera_merge' => false,
  }}

  context 'include_exclude' do
    let(:params) { validation_params.merge({
      'classes' => {
        'my_class1' => true,
        'my_class2' => false,
        'my_class4' => true,
      }
    }) }

    it { should compile.with_all_deps }
    it { should contain_class('loader') }

    it { should contain_class('my_class1') }
    it { should_not contain_class('my_class2') }
    it { should_not contain_class('my_class3') }
    it { should contain_class('my_class4') }
  end

  context 'ensure_absent' do
    let(:params) { validation_params.merge({
      'classes' => {
        'my_class1' => true,
        'my_class2' => true,
        'my_class4' => true,
      },
      'ensure' => 'absent',
    }) }

    it { should compile.with_all_deps }
    it { should contain_class('loader') }

    it { should_not contain_class('my_class1') }
    it { should_not contain_class('my_class2') }
    it { should_not contain_class('my_class3') }
    it { should_not contain_class('my_class4') }
  end
end

# vim: set expandtab sw=2 ts=2:
