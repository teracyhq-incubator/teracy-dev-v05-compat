#
# Author:: Hoat Le <hoatlevan@gmail.com>
# Cookbook:: teracy-dev
# Recipe:: files
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

# Manage files with file resource: using src as path for content source and dest
# path as the saved destination path
#
# see: https://docs.chef.io/resource_file.html
#
# example:
#
# teracy-dev:
#   # copy certs files for nginx proxy
#   files:
#     - _id: teracy-common-cert-key
#       src: /vagrant/workspace/certs/teracy-local-key.pem
#       dest: /etc/nginx/certs/teracy.local.key
#       owner: vagrant
#       group: vagrant
#       mode: '0755'
#       action: create
#     - _id: teracy-common-cert
#       src: /vagrant/workspace/certs/teracy-local.crt
#       dest: /etc/nginx/certs/teracy.local.crt
#       owner: vagrant
#       group: vagrant
#       mode: '0755'
#       action: create

files = node['teracy-dev']['files'] || []

def sym_action(opt)
  opt['action'].nil? || opt['action'].strip().empty? ? :create : opt['action'].to_sym
end

files.each do |file_conf|
  act = sym_action(file_conf)
  file file_conf['dest'] do
    content ::File.open(file_conf['src']).read
    owner file_conf['owner']
    group file_conf['group']
    mode file_conf['mode']
    action act
  end
end
