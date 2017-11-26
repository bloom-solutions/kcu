require "awesome_print"
require "base64"
require "commander"
require "json"
require "light-service"
require "open3"

module Kcu
end

require "kcu/version"
require "kcu/summary"
require "kcu/services/get_resource_namespace_and_name"
require "kcu/services/secrets/get_json"
require "kcu/services/secrets/decode_data"
require "kcu/services/secrets/get_entry_value"
require "kcu/services/secrets/encode_entry_value"
require "kcu/services/secrets/set_entry_value"
require "kcu/services/secrets/get_entry_value"
require "kcu/actions/list_secret_action"
require "kcu/actions/get_secret_action"
require "kcu/actions/set_secret_action"
require "kcu/client"

Kcu.new.run if $0 == __FILE__
