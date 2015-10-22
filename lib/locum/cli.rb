# encoding: utf-8
require 'thor'
require 'locum'

module Locum
  class SshKey < Thor
    desc 'add', 'Настраивает беспарольную авторизацию по ключу'
    option :key

    def add
      key_file = options[:key] || File.join(ENV['HOME'], '.ssh', 'id_rsa.pub')
      until File.exist?(key_file) do
        cn.say("Файл #{key_file} не найден.")
        key_file = Locum.cn.ask('Имя файла с публичным ключом и путём: ')
      end
      cn.say "Используется ключ #{key_file}"

      ssh_auth = Locum::Ssh.new
      ssh_auth.add_ssh_key(key_file)

      s_out "Теперь вы можете авторизоваться по SSH без пароля"
    end
  end

  class CLI < Thor

    desc 'init', 'Получает token для работы с сервисом'
    option :login
    option :password

    def init
      cn.say("\nНастройка интерфейса командной строки locum.ru\n\n")

      login    = options[:login] || cn.ask('login: ')
      password = options[:password] || cn.ask('пароль: ') { |q| q.echo = false }

      s_out "Получаем токен https://locum.ru"

      authenticator = Locum::Auth.new(login, password)

      authenticator.persist_token

      s_in "Токен получен\n\n"

      cn.say <<EOFBLOCK
    Авторизационный токен для доступа к вашим проектам сохранен в
    текущем каталоге в файле <%= color('.locum', BOLD) %>.
    Возможно, вы не хотите, чтобы этот токен попал в систему контроля
    версий. В этом случае вам нужно добавить исключение в ваш .gitignore
    или его аналог.

    Выданный токен можно отозвать в любой момент через панель управления
    хостингом.

    Интерфейс командной строки настроен, используйте команду
    <%= color('locum help', BOLD) %> для получения списка возможных действий и справки.

EOFBLOCK

    rescue ApiError => e
      display_error(e)
    end

    desc 'ping', 'Проверка связи с API'

    def ping
      s_out "PING"

      ping = Locum::Ping.new
      ping.call

      s_in "PONG login: #{ping.login} till #{ping.valid}\n\n"

    rescue ApiError => e
      display_error(e)
    end

    desc 'projects', 'Список проектов'

    def projects
      projects = Locum::Projects.new
      projects.call

      projects.projects.each { |p| say("  * #{p['name']} (##{p['id']} #{p['type']})") }
    end

    desc 'cap', 'Настройка проекта для работы с Capistrano'

    def cap
      Locum::Cap.start
    end

    desc 'ssh_key', 'Работа с ключами'
    subcommand 'ssh_key', SshKey
  end

end

include Locum::Console
