module Kcu
  class Container

    extend Dry::Initializer

    option :namespace
    option :deployment_name
    option :name

  end
end
