#
# Cookbook Name:: users
# Recipe:: sysadmins
#
# Copyright 2011, Eric G. Wolfe
# Copyright 2009-2011, Opscode, Inc.
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

# Searches data bag "users" for groups attribute "sysadmin".
# Places returned users in Unix group "sysadmin" with GID 2300.
node[:users][:groups].each do |group|
  users_manage node[:users][group.to_sym][:name] do
    group_id     node[:users][group.to_sym][:id]
    data_bag     node[:users][group.to_sym][:data_bag]     if node[:users][group.to_sym].key?(:data_bag)
    search_group node[:users][group.to_sym][:search_group] if node[:users][group.to_sym].key?(:search_group)
    group_name   node[:users][group.to_sym][:group_name]   if node[:users][group.to_sym].key?(:group_name)
    group_id     node[:users][group.to_sym][:group_id]
    cookbook     node[:users][group.to_sym][:cookbook]     if node[:users][group.to_sym].key?(:cookbook)
    action       [ :remove, :create ]
  end
end