# encoding: utf-8

class Locum::Projects
  attr_accessor :projects

  def call
    res    = Locum::Api.call(:projects)
    @projects = res['projects']
  end
end
