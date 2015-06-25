# encoding: UTF-8
#
# Cookbook Name:: swap_tuning_test
# Recipe:: default
# Author:: Xabier de Zuazo (<xabier@onddo.com>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL. (www.onddo.com)
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

self.class.send(:include, Chef::SwapTuning::RecipeHelpers)

# Disable swap included in the testing box images
bash 'swapoff -a' do
  code <<-EOH
    cat /proc/swaps | sed '1d' | awk '{print $1}' \
      | grep -v '^#{Regexp.escape(node['swap_tuning']['file_prefix'])}' \
      | xargs -r swapoff
  EOH
  action :nothing
end.run_action(:run)

node.automatic['memory']['swap']['total'] = '0kB' if oldchef?

include_recipe 'swap_tuning'