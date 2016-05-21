#!/usr/bin/env rspec
require 'spec_helper'

describe 'users', :type => :define do

  describe 'test simple user hash' do

    let :title do
      'bar'
    end
    let :params do
      { 'hash ' => { 'foo' => { 'uid' => '123' } } }
    end

    it { should contain_users('bar') }
    it { should contain_users__setup('foo').with_hash({'foo'=>{'uid'=>'123'}}) }
    it { should contain_user('foo').with_uid(123) }
  end

  describe 'hiera specified simple user hash' do
    let :title do
      'baz'
    end

    it { should contain_users('baz') }
    it { should contain_users__setup('foo').with_hash({'foo'=>{'uid'=>'123'}}) }
  end

  describe 'hiera multilevel hashes' do
    let :facts do
      {
        :clientcert => 'test',
      }
    end

    let :title do
      'test'
    end

    it { should contain_users('test') }
    it { should contain_users__setup('foo').with_hash(
      {
        'foo' => {'uid' => '123'},
        'bar' => {'uid' => '321'},
      }
    ) }
    it { should contain_users__setup('bar').with_hash(
      {
        'foo' => {'uid' => '123'},
        'bar' => {'uid' => '321'},
      }
    ) }
    it { should contain_user('bar') }
  end

  describe 'hiera multilevel hashes - first only' do
    let :facts do
      {
        :clientcert => 'test',
      }
    end

    let :title do
      'test'
    end

    let :params do
      {
        'match' => 'first'
      }
    end

    it { should contain_users('test') }
    it { should_not contain_users__setup('foo') }
    it { should contain_users__setup('bar').with_hash(
      {
        'bar' => {'uid' => '321'},
      }
    ) }
  end

end

# vim: ts=2 sw=2 sts=2 et ai :
