module Kcu
  class ExecShell

    def self.call(*args)
      command_parts = []
      args.each do |arg|
        if arg.is_a?(Hash)
          arg.each do |key, value|
            command_parts << [key, value].join("=")
          end
        else
          command_parts << arg
        end
      end

      command = command_parts.join(" ")

      Open3.capture3(command)
    end

  end
end
