require 'thor/group'

module Locum
  class Cap < Thor::Group
    include Thor::Actions

    def self.source_root
      File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    end

    def arguments
      hu   = Locum::HostingUnit.get
      ping = Locum::Ping.new

      ping.call

      @login   = ping.login
      @project = File.basename(Dir.pwd)
      @user    = hu.login
      @server  = hu.server

      @cap_version = Gem::Specification.find_by_name('capistrano').version.to_s
    end

    def capfile
      template('templates/capfile.erb', 'Capfile')
    end

    def deploy_rb
      template('templates/deploy.erb', 'config/deploy.rb')
    end

    def locum_stage
      template('templates/locum.erb', 'config/deploy/locum.rb')
    end

    def ssh_key
      Locum::CLI.start(['ssh_key', 'add'])
    end

    def notify
      cn.say <<EOFBLOCK

   Для проекта создана конфигурация Capistrano и настроен деплой для
   окружения locum. Проверьте версию ruby в файле <%= color('config/deploy.rb', BOLD) %>
   и используйте <%= color('cap locum deploy', BOLD) %> для выкладки изменений на сервер.

EOFBLOCK
    end

  end
end
