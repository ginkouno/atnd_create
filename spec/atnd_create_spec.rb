# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'webmock/rspec'

describe "atnd create" do
  describe 'initialize' do
    context 'login type error' do
      it "raise error" do
        lambda{ AtndCreate::Event.new("account", "password", {:login_type => "hoge"}) }.should raise_error(AtndCreate::AtndCreateException)
      end
    end

    context 'login type is correct' do
      it "raise not error" do
        lambda{ AtndCreate::Event.new("account", "password", {:login_type => :google}) }.should_not raise_error
      end
    end
  end

  describe 'login_google' do
    context 'success' do
    end

    context 'failure' do
    end
  end
end
