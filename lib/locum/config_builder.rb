# encoding: utf-8
require 'yaml'
require 'locum/config'

module Locum::ConfigBuilder
  CONFIG_FILE = '.locum'.freeze

  def self.load
    YAML.load_file(CONFIG_FILE, permitted_classes: [Locum::Config])
  rescue Errno::ENOENT
    raise Errno::ENOENT, 'Не найден файл конфигурации. Запустите locum init, чтобы его создать'
  end

  def self.save(config)
    File.write(CONFIG_FILE, YAML.dump(config))
  end
end
