#
# Cookbook Name:: docker_compose
# Recipe:: uninstallation
#

def existing_docker_compose_path
  existing_docker_compose_path = Mixlib::ShellOut.new("which docker-compose")

  existing_docker_compose_path.run_command

  existing_path = ''

  existing_path = existing_docker_compose_path.stdout.strip unless existing_docker_compose_path.stdout.empty?

  existing_path
end

docker_compose_path = node['docker_compose']['command_path']
docker_compose_autocomplete_path = node['docker_compose']['autocomplete_path']
existing_path = existing_docker_compose_path()

file docker_compose_path do
  action :delete
  only_if { File.exist?(docker_compose_path) }
end

file docker_compose_autocomplete_path do
  action :delete
  only_if { File.exist?(docker_compose_autocomplete_path) }
end

unless existing_path.empty?
	file existing_path do
		action :delete
	end
end
