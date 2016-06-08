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

service "crond" do
  action :enable
end

service "auditd" do
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
  action :create
end

execute 'kernel_parameters' do
  command '/sbin/sysctl -w net.ipv4.conf.all.send_redirects=0'
#  not_if 'bundle check' # This is not run inside /myapp
end

execute 'kernel_parameters_3' do
  command '/sbin/sysctl -w net.ipv4.route.flush=1'
#  not_if 'bundle check' # This is not run inside /myapp
end

execute 'kernel_parameters_4' do
  command '/sbin/sysctl -w net.ipv4.conf.default.send_redirects=0'
#  not_if 'bundle check' # This is not run inside /myapp
end

execute 'kernel_parameters_5' do
  command '/sbin/sysctl -w net.ipv4.conf.all.accept_redirects=0'
#  not_if 'bundle check' # This is not run inside /myapp
end

execute 'kernel_parameters_6' do
  command '/sbin/sysctl -w net.ipv4.conf.default.accept_redirects=0'
#  not_if 'bundle check' # This is not run inside /myapp
end

execute 'kernel_parameters_7' do
  command '/sbin/sysctl -w net.ipv4.conf.all.secure_redirects=0'
#  not_if 'bundle check' # This is not run inside /myapp
end

execute 'kernel_parameters_8' do
  command '/sbin/sysctl -w net.ipv4.conf.default.secure_redirects=0'
#  not_if 'bundle check' # This is not run inside /myapp
end

execute 'kernel_parameters_9' do
  command '/sbin/sysctl -w net.ipv4.conf.all.log_martians=1'
#  not_if 'bundle check' # This is not run inside /myapp
end

execute 'kernel_parameters_10' do
  command '/sbin/sysctl -w net.ipv4.conf.default.log_martians=1'
#  not_if 'bundle check' # This is not run inside /myapp
end