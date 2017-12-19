require 'spec_helper'

module Kcu
  module Deploys
    RSpec.describe GenImageName do

      let(:kcu_config) do
        YAML.load_file(SPEC_DIR.join("fixtures", "kcu.yml"))
      end
      let(:git_repo_path) do
        Pathname.new(File.join("/tmp", "git_repo-#{Time.now.to_i}"))
      end
      let(:git_repo) { Git.init(git_repo_path.to_s) }

      before do
        git_repo.branch("master")

        FileUtils.touch(git_repo_path.join("hello.txt"))
        git_repo.add(all: true)
        git_repo.commit("First commit")

        FileUtils.touch(git_repo_path.join("hello2.txt"))
        git_repo.add(all: true)
        git_repo.commit("Second commit")

        git_repo.branch("staging_11").checkout

        FileUtils.touch(git_repo_path.join("hello3.txt"))
        git_repo.add(all: true)
        git_repo.commit("Third, staging commit")
      end

      it "generates the image name" do
        resulting_ctx = described_class.execute(
          image_config: kcu_config["deploys"][1],
          git_branch: "staging_11",
          repo_dir: git_repo_path,
        )
        test_repo = Git.open(git_repo_path)
        test_repo.branch("staging_11").checkout
        expect(resulting_ctx.image_name).
          to eq "gcr.io/bloom-solutions/website:staging-#{test_repo.log(1).first.sha}"

        resulting_ctx = described_class.execute(
          image_config: kcu_config["deploys"][0],
          git_branch: "master",
          repo_dir: git_repo_path,
        )
        test_repo = Git.open(git_repo_path)
        test_repo.branch("master").checkout
        expect(resulting_ctx.image_name).
          to eq "gcr.io/bloom-solutions/website:prod-#{test_repo.log(1).first.sha}"
      end

    end
  end
end
