require "pry-byebug"

module Kcu
  class Client

    include Commander::Methods

    def run(working_dir:)
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

      command :"secret get" do |c|
        c.syntax = "secret get namespace/secret_name entry_name"
        c.description = "Return decoded value of specified secret"
        c.action do |args, options|
          GetSecretAction.(*args)
        end
      end

      command :"secret set" do |c|
        c.syntax = "secret set namespace/secret_name entry_name [value or --from-file=/path]"
        c.description = "Set an entry in a secret by giving a non-base64 encoded value"
        c.option "--from-file String", String, "Uses contents of file as the value. `kcu secret set namespace/secret_name entry_name --from-file=/tmp/config.cfg`"
        c.action do |args, options|
          SetSecretAction.(args, options)
        end
      end

      command :"deployment restart" do |c|
        c.syntax = "deployment restart namespace/deployment_name"
        c.description = "Restarts a deployment"
        c.action do |args, options|
          RestartDeploymentAction.(*args)
        end
      end

      command :deploy do |c|
        c.syntax = "deploy master"
        c.description = "Deploy a branch"
        c.action do |args, options|
          DeployAction.(*args.insert(0, working_dir))
        end
      end

      run!
    end

  end
end
