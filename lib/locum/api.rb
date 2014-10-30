# encoding: utf-8
require 'json'

class Locum::Api
  HOST        = ENV['DEV'] ? 'localhost:3000' : 'locum.ru'
  SCHEMA      = ENV['DEV'] ? 'http' : 'https'
  API_VERSION = 1

  API  = "#{SCHEMA}://#{HOST}/api/v#{API_VERSION}/".freeze

  def self.api
    API
  end

  def call(method, params)

  end

  def self.read_token

  end
end
