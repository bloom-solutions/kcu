module Kcu
  module Deploys
    class GetConfig

      CONFIG_FILE_NAME = "kcu.yml"
      extend LightService::Action
      expects :repo_dir
      promises :config

      executed do |c|
        file_path = File.join(c.repo_dir, CONFIG_FILE_NAME)
        if File.exists?(file_path)
          c.config = YAML.load_file(file_path)
        else
          fail ArgumentError, "#{CONFIG_FILE_NAME} is not present in #{c.repo_dir}"
        end
      end

    end
  end
end
