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
    it { should contain_users__setup('foo').with_hash({"foo"=>{"uid"=>"123"}}) }
    it { should contain_user('foo').with_uid(123) }
  end

  describe 'hiera specified simple user hash' do
    let :title do
      'bar'
    end

    let(:hiera_data) do
      { 'users_bar' => {'foo' => { 'uid' => '123' } } }
    end

    it { should contain_users('bar') }
    it { should contain_users__setup('foo').with_hash({"foo"=>{"uid"=>"123"}}) }
  end
end
