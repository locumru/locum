# encoding: utf-8
require 'net/ssh'

class Locum::Ssh
  def add_ssh_key(key_file)
    @key = File.read(key_file).strip

    run_on_server("mkdir .ssh")
    run_on_server("echo #{@key} >> .ssh/authorized_keys")
  end

  def hu
    @hu ||= Locum::HostingUnit.get
  end

  private

  def run_on_server(cmd)
    begin
      Net::SSH.start(hu.server, hu.login, :password => hu.password) do |ssh|
        ssh.exec!(cmd)
      end
    rescue Net::SSH::HostKeyMismatch => e
      e.remember_host!
      retry
    rescue StandardError => e
      raise ApiError, e.to_s
    end
  end
end
