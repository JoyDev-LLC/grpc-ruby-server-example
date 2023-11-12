# frozen_string_literal: true

require 'gruf'

Gruf.configure do |c|
  c.rpc_server_options = c.rpc_server_options.merge(pool_size: 100)
  c.error_serializer = Gruf::Serializers::Errors::Json
end
