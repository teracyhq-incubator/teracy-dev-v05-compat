#
# Cookbook Name:: docker_compose
# Recipe:: installation
#
# Copyright (c) 2016 Sebastian Boschert, All Rights Reserved.

def get_release_version
  release = node['docker_compose']['release']
  release
end

def get_install_url
  kernel_name = node['kernel']['name']
  machine_hw_name = node['kernel']['machine']
  "https://github.com/docker/compose/releases/download/#{get_release_version}/docker-compose-#{kernel_name}-#{machine_hw_name}"
end

def get_autocomplete_url
    "https://raw.githubusercontent.com/docker/compose/#{get_release_version}/contrib/completion/bash/docker-compose"
end

command_path = node['docker_compose']['command_path']
install_url = get_install_url

package 'curl' do
  action :install
end

directory '/etc/docker-compose' do
  action :create
  owner 'root'
  group 'docker'
  mode '0750'
end

execute 'install docker-compose' do
  action :run
  command "curl -sSL #{install_url} > #{command_path} && chmod +x #{command_path}"
  creates command_path
  user 'root'
  group 'docker'
  umask '0027'
  not_if "#{command_path} --version | grep #{node['docker_compose']['release']}"
end

autocomplete_path = node['docker_compose']['autocomplete_path']

autocomplete_url = get_autocomplete_url()

# install docker-compose auto complete
execute 'install docker-compose autocomplete' do
  action :run
  command "curl -sSL #{autocomplete_url} > #{autocomplete_path}"
  creates autocomplete_path
  user 'root'
  group 'docker'
  only_if { node['platform'] == 'ubuntu' }
end
