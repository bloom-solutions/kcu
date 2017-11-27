require 'spec_helper'

module Kcu
  RSpec.describe ExecShell do

    it "executes the given command in the shell" do
      expect(Open3).to receive(:capture3).
        with(%Q(kubectl patch deployment web --namespace=prod --patch=ok)).
        and_return(["stdout", "stderr", 0])

      result = described_class.(
        "kubectl",
        "patch",
        "deployment",
        "web",
        {
          "--namespace" => "prod",
          "--patch" => "ok",
        }
      )

      expect(result).to eq(["stdout", "stderr", 0])
    end

  end
end
