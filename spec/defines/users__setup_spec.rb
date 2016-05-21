#!/usr/bin/env rspec
require 'spec_helper'

describe 'users::setup', :type => :define do

  describe 'basic user' do
    let :title do
      'foo'
    end

    let :params do
      {
        'hash'  => {
          'foo' => {
            'uid' => '123',
          },
        },
      }
    end

    it { should compile }
    it { should contain_user('foo').with_uid('123') }
  end

  describe 'user with ssh_authorized_key' do
    let :title do
      'foo'
    end

    let :params do
      {
        'hash'  => {
          'foo' => {
            'uid' => '123',
            'ssh_authorized_keys' => {
              'foo' => {
                'type' => 'ssh-rsa',
                'key'  => 'foo_key',
              }
            },
          },
        },
      }
    end

    it { should contain_users__ssh_authorized_keys('foo').with(
      {
        'user' => 'foo',
        'hash' => { 'foo' => {
            'type' => 'ssh-rsa',
            'key'  => 'foo_key',
          }
        },
      }
    ) }
    it { should contain_ssh_authorized_key('foo-foo') }
  end

  describe 'user with multiple ssh_authorized_keys' do
    let :title do
      'foo'
    end

    let :params do
      {
        'hash'  => {
          'foo' => {
            'uid' => '123',
            'ssh_authorized_keys' => {
              'foo' => {
                'type' => 'ssh-rsa',
                'key'  => 'foo_key',
              },
              'bar' => {
                'type' => 'ssh-rsa',
                'key'  => 'bar_key',
              },
            },
          },
        },
      }
    end

    it { should contain_users__ssh_authorized_keys('foo') }
    it { should contain_users__ssh_authorized_keys('bar') }
    it { should contain_ssh_authorized_key('foo-foo') }
    it { should contain_ssh_authorized_key('foo-bar') }
  end

end

# vim: ts=2 sw=2 sts=2 et ai :
