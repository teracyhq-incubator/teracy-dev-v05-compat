# Author:: Hoat Le <hoatle@teracy.com>
# Cookbook:: teracy-dev
# Recipe:: docker_registry
# Login into the Docker registries

docker_conf = node['docker']

docker_registry_conf = node['docker_registry']

if docker_conf['enabled'] == true
  execute 'rm ~/.docker/config.json' do
    command 'rm /home/vagrant/.docker/config.json || true'
    only_if do
      (docker_registry_conf['force'] == true) &&
        File.exist?('/home/vagrant/.docker/config.json')
    end
  end

  docker_registry_conf['entries'].each.with_index do |entry, _index|
    # private registry login

    username = entry['username'] ? entry['username'] : ''

    password = entry['password'] ? entry['password'] : ''

    if !username.empty? && !password.empty?
      opt = [
          "-u #{username}",
          "-p #{password}",
      ].join(' ')

      execute 'docker login' do
        command "docker login #{entry['host']} #{opt}"
        # because we need root to execute docker-compose, not 'vagrant'
        only_if do
          (docker_registry_conf['force'] == true) ||
            !File.exist?('/root/.docker/config.json')
        end
      end
    end
  end

  execute 'copy /root/.docker/config.json to ~/.docker/config.json' do
    command 'cp /root/.docker/config.json /home/vagrant/.docker/config.json'
    only_if do
      File.exist?('/root/.docker/config.json') && (
          (docker_registry_conf['force'] == true) ||
          !File.exist?('/home/vagrant/.docker/config.json')
        )
    end
  end
end
