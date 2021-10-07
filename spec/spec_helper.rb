# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  minimum_coverage 95
  add_filter 'spec'
  add_filter 'vendor'
end

require 'bundler/setup'
require 'codebreaker_gem'
require 'ffaker'

require_relative 'spec_requires'
