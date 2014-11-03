# encoding: utf-8
require 'locum/api'

class Locum::Auth
  attr_accessor :login, :password

  def initialize(login, password)
    @login    = login
    @password = password
  end

  def persist_token
    res = Locum::Api.call(:get_token, { login: @login, password: password }, false)
    if res['result'] == 'ok'
      @token = res['token']
      store_token

      return @token
    else
      raise ApiError, res['status']
    end
  end

  def store_token
    begin
      config = Locum::ConfigBuilder.load
    rescue
      config = Locum::Config.new
    end

    config.token = @token
    Locum::ConfigBuilder.save(config)
  end
end
