require "pry-byebug"

module Kcu
  class Client

    include Commander::Methods

    def run
      program :name, "Kubectl Utils (KCU)"
      program :version, Kcu::VERSION
      program :description, Kcu::SUMMARY

      command :"secret list" do |c|
        c.syntax = "secret list namespace/secret_name"
        c.description = "List decoded secrets"
        c.action do |args, options|
          ListSecretAction.(args[0])
        end
      end

      run!
    end

  end
end
