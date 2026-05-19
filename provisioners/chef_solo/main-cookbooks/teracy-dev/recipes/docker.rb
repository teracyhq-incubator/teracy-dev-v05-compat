#
# Author:: Hoat Le <hoatle@teracy.com>
# Cookbook:: teracy-dev
# Recipe:: docker
#
# Copyright:: 2013 - current, Teracy, Inc.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:

#     1. Redistributions of source code must retain the above copyright notice,
#        this list of conditions and the following disclaimer.

#     2. Redistributions in binary form must reproduce the above copyright
#        notice, this list of conditions and the following disclaimer in the
#        documentation and/or other materials provided with the distribution.

#     3. Neither the name of Teracy, Inc. nor the names of its contributors may be used
#        to endorse or promote products derived from this software without
#        specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# NOTE: Don't use the same attributes from docker cookbook to avoid overlapping
docker_conf = node['docker']

if docker_conf['enabled'] == true

  act = :create
  if docker_conf['action'] == 'delete'
    act = :delete
  end

  if docker_conf['ver'] && !docker_conf['ver'].empty?

    docker_installation_package 'default' do
      version docker_conf['ver']
      action act
      package_options docker_conf['pkg_options']
    end

  else

    docker_installation_package 'default' do
      action act
      package_options docker_conf['pkg_options']
    end

  end

  group 'docker' do
    action :modify
    members docker_conf['members']
    append true
  end

end
