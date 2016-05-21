#!/usr/bin/env rspec
require 'spec_helper'

describe 'users::ssh_authorized_keys', :type => :define do
  
  describe 'basic user with single key' do
    let :title do
      'foo'
    end

    let(:params) {
      {
        'user' => 'foo',
        'hash' => {
          'foo' => {
            'type'  => 'ssh-rsa',
            'key'   => 'foo_key',
          }
        },
      }
    }

    it { should compile }
    it { should contain_ssh_authorized_key('foo-foo') }
  end

end

# vim: ts=2 sw=2 sts=2 et ai :
