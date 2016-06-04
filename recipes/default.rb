#
# Cookbook Name:: inspec-workshop-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

cookbook_file '/etc/grub.conf' do
  source 'grub.conf'
  action :create
end

cookbook_file '/etc/security/limits.conf' do
  source 'limits.conf'
  action :create
end

cookbook_file '/etc/sysctl.conf' do
  source 'sysctl.conf'
  action :create
end

directory '/etc/sysconfig'

cookbook_file '/etc/sysconfig/init' do
  source 'init'
#  action :create <----don't really need it because create is the default setting for actions
end

package 'ntp'
package 'ntpdate'
package 'ntp'