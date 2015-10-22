# encoding: utf-8
require 'highline/import'

module Locum
  module Console
    private

    def display_error e
      cn = HighLine.new
      cn.say("\n<%= color('Произошла ошибка:', RED) %> #{e.message}")
    end

    def cn
      @cn ||= HighLine.new
    end

    def s_out(s)
      cn.say("\n<%= color('->', GREEN) %> #{s}")
    end

    def s_in(s)
      cn.say("<%= color('<-', CYAN) %> #{s}")
    end
  end
end
