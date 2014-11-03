# encoding: utf-8

class Locum::Ping
  attr_accessor :login, :valid

  def call
    res    = Locum::Api.call(:ping)
    @login = res['login']
    @valid = res['valid']
  end
end