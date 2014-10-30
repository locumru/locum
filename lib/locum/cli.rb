# encoding: utf-8
require 'thor'
require 'highline/import'

class Locum::CLI < Thor
  desc 'init', 'Получает token для работы с сервисом'
  option :login
  option :password
  def init
    cn = HighLine.new

    login = options[:login] || cn.ask('login: ')
    password = options[:password] || cn.ask('password: ') { |q| q.echo = false }

    puts "#{login}:#{password}"
  end
end
