require 'spec_helper'

describe 'loader::load' do
  let(:pre_condition) {[
    'class my_class1() {}',
    'class my_class2() {}',
    'class my_class3() {}',
  ]}
  let(:params) {{
    :classes => {
      'my_class1' => false,
      'my_class2' => true,
    }
  }}

  context 'exclude' do
    let(:title) { 'my_class1' }

    it { should_not contain_class('my_class1') }
  end

  context 'include' do
    let(:title) { 'my_class2' }

    it { should contain_class('my_class2') }
  end

  context 'undefined' do
    let(:title) { 'my_class3' }

    it { should_not contain_class('my_class2') }
  end
end

# vim: set expandtab sw=2 ts=2:
