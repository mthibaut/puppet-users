#!/usr/bin/env rspec
#require 'ruby-debug'
#require 'pp'
require 'spec_helper'

describe 'users', :type => :define do

  describe 'directly specified simple user hash - no hiera' do

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

    let :hiera_data do
      { 'users_bar' => {'foo' => { 'uid' => '123' } } }
    end

    it { should contain_users('bar') }
    it 'should do it' do
      #Puppet::Util::Log.level = :debug
      #Puppet::Util::Log.newdestination(:console)
      #debugger
      should contain_users__setup('foo').with_hash({"foo"=>{"uid"=>"123"}})
    end
    it { should contain_users__setup('foo').with_hash({"foo"=>{"uid"=>"123"}}) }
    it { should contain_user('foo').with_uid(123) }

  end
end
