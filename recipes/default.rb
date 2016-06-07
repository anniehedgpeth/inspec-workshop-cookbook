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

# directory '/etc/sysconfig'

cookbook_file '/etc/sysconfig/init' do
  source 'init'
#  action :create <----don't really need it because create is the default setting for actions
end

package 'ntp'
package 'ntpdate'
package 'ntp'
package 'rsyslog'
package 'tcp_wrappers'

service "iptables" do
  action :enable
end

service "syslog" do
  action :disable
end

cookbook_file '/etc/hosts.allow' do
  source 'hosts.allow'
  owner 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/hosts.deny' do
  source 'hosts.deny'
  owner 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/rsyslog.conf' do
  source 'rsyslog.conf'
  action :create
end

service 'rsyslog' do
  action :restart
end

cookbook_file '/etc/audit/auditd.conf' do
  source 'auditd.conf'
end

# cookbook_file '/etc/audit/auditd' do
#   action :write
# end