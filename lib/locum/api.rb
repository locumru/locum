# encoding: utf-8
require 'json'
require 'net/http'
require 'locum/config'

module Locum::Api
  HOST        = ENV['DEV'] ? 'localhost:3000' : 'locum.ru'
  SCHEMA      = ENV['DEV'] ? 'http' : 'https'
  API_VERSION = 1

  API  = "#{SCHEMA}://#{HOST}/api/v#{API_VERSION}/".freeze

  def self.api
    API
  end

  def self.call(method, params = {}, tokenized = true)
    token = tokenized ? self.token : nil
    uri   = URI("#{API}#{method}")
    res   = Net::HTTP.post_form(
        uri,
        { :token  => token }.merge(params)
    )

    result = JSON.parse(res.body.to_s)

    if result['result'] == 'error'
      raise ApiError, result['status']
    end

    result
  end

  def self.token
    Locum::Config.get.token
  end
end
