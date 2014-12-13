# encoding: utf-8

class Locum::HostingUnit
  attr_accessor :login, :password, :server

  def self.get
    res = Locum::Api.call(:hosting_unit)
    res = res['hosting_unit']
    hu  = self.new

    hu.login    = res['login']
    hu.password = res['password']
    hu.server   = "#{res['server']}.locum.ru"

    hu
  end
end
