module Kcu
  module Deploys
    class GenImageName

      extend LightService::Action
      expects :image_config, :git_branch, :repo_dir
      promises :image_name

      executed do |c|
        git = Git.open(c.repo_dir)
        git.branch(c.git_branch)
        git_commit = git.log(1).first.sha

        c.image_name = c.image_config["template"].
          gsub("$GIT_COMMIT", git_commit)
      end

    end
  end
end
