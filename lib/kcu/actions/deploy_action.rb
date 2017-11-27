module Kcu
  class DeployAction

    extend LightService::Organizer

    def self.call(repo_dir, git_branch, target_namespace=nil)
      with(
        repo_dir: repo_dir,
        git_branch: git_branch,
        target_namespace: target_namespace,
      ).reduce(
        Deploys::GetConfig,
        Deploys::GetImageConfig,
        Deploys::GenImageName,
        Deploys::SetTargetNamespace,
        Deploys::GetTargetContainersConfig,
        Deploys::GetTargetContainers,
        Deploys::SetImage,
      )
    end

  end
end
