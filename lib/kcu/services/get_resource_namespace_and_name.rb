module Kcu
  class GetResourceNamespaceAndName

    extend LightService::Action
    expects :resource
    promises :resource_namespace
    promises :resource_name

    executed do |c|
      namespace, name = c.resource.split("/")

      if name.nil?
        c.resource_namespace = "default"
        c.resource_name = namespace
      else
        c.resource_namespace = namespace
        c.resource_name = name
      end
    end

  end
end
