# this script takes the API key and other settings from the opsworks stack custom json
# the custom json must look like this:
# {
#   "deploy": {
#     "SERVER_OR_APPLICATION_NAME": {
#       "environment_variables": {
#         "VAR_NAME": "VAR_VALUE",
#         "SCOUT_API_KEY": "pDyfJxLjE6IoOe0WUzDFVGXCbFapI4mMwgralM7Q"
#       },
#       "rails_env": "production"
#     }
#   }
# }

include_attribute 'deploy'

# getting the api key from the custom json.
# note that we only put one node on the deploy custom json.
application_name, deploy = node[:deploy].first
unless deploy[:environment_variables]
  Chef::Log.info("> Scout error: missing deploy[:environment_variables]")
end
if deploy[:environment_variables]['SCOUT_API_KEY']
  Chef::Log.info("> Scout: found SCOUT_API_KEY")
  default[:scout][:key] = deploy[:environment_variables]['SCOUT_API_KEY']
else
  Chef::Log.info("> Scout error: missing deploy[:environment_variables]['SCOUT_API_KEY']")
end

# User to run the Scout agent under. Will be created if it does not exist.
# User group to run the Scout agent under. Will be created if it does not exist.
# user and group are set to 'deploy', the opsworks deploy account used to run recipes and deploy
default[:scout][:user] = 'deploy'
default[:scout][:group] = 'www-data'

# Optional name to display for this node within the Scout UI.
# we will get this from the custom json node name under the deploy node
default[:scout][:name] = application_name
# An Array of roles for this node. Roles are defined through Scout's UI.
default[:scout][:roles] = nil

# The full path to the scout gem executable. When nil, this is discovered via Gem#bindir.
# opsworks puts gem bins in /usr/local/bin, so point there
default[:scout][:bin] = '/usr/local/bin/scout'

# Gem version to install. nil installs the latest release.
default[:scout][:version] = nil

# If you use self-signed custom plugins, set this attribute to the public key value and it'll be installed on the node.
default[:scout][:public_key] = nil

# new stuff, not described in the README.
default[:scout][:http_proxy] = nil
default[:scout][:https_proxy] = nil
default[:scout][:delete_on_shutdown] = false	# create rc.d script to remove the server from scout on shutdown

# list of gems to install to support plugins for role
default[:scout][:plugin_gems] = []

# The environment you would like this server to belong to, if you use environments.
# Environments are defined through scoutapp.com's web UI.
# environment defined in custom json
Chef::Log.info("> Setting up scout in #{deploy[:rails_env]} rails environment")
default[:scout][:environment] = deploy[:rails_env]

# Hash. Used to generate a plugins.properties file from encrypted data bags for secure lookups.
# E.g. "haproxy.password" => {"encrypted_data_bag" => "shared_passwords", "item" => "haproxy_stats", "key" => "password"}
# will create a plugins.properties entry with "haproxy.password=PASSWORD"
# where PASSWORD is an encrypted data bag item "haproxy_stats" in encrypted_data_bag "shared_passwords" with key "password".
default[:scout][:plugin_properties] = {}
