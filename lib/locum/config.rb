# encoding: utf-8
require 'locum/config_builder'

class Locum::Config
  attr_accessor :token

  def self.get
    @config ||= Locum::ConfigBuilder.load
  end
end
