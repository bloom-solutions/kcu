module Kcu
  module Deploys
    class GetImageConfig

      extend LightService::Action
      expects :git_branch, :config
      promises :image_config

      executed do |c|
        c.image_config = catch(:config) do
          c.config["deploys"].find do |conf|
            config_branch = conf["branch"]
            if config_branch.include?("/")
              throw(:config, conf) if c.git_branch =~ config_branch.to_regexp
            else
              throw(:config, conf) if c.git_branch == config_branch
            end
          end

          fail ArgumentError, "`#{c.git_branch}` branch is not configured"
        end
      end

    end
  end
end
