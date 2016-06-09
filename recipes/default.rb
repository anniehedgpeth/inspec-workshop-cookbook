#
# Cookbook Name:: inspec-workshop-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

files={
  'grub.conf'=> '/etc/grub.conf',
  'limits.conf'=> '/etc/security/limits.conf',
  'sysctl.conf'=> '/etc/sysctl.conf',
  'sshd_config'=> '/etc/ssh/sshd_config',
  'init'=> '/etc/sysconfig/init', 
  'rsyslog.conf'=> '/etc/rsyslog.conf',
  'auditd.conf'=> '/etc/audit/auditd.conf'
}
files.each do |key,value|
  cookbook_file value do
    source key
    action :create
  end
end

['/etc/cron.monthly','/etc/crontab'].each do |name|
   directory name do
     owner 'root'
     group 'root'
     mode 0600
   end
 end

['ntp','ntpdate','rsyslog','tcp_wrappers'].each do |name|
    package name
end

['iptables','crond','auditd','rsyslog'].each do |name|
   service name do
     action :enable
   end
 end
 
 service 'rsyslog' do
  action :restart
end

files={
  'hosts.allow'=> '/etc/hosts.allow',
  'hosts.deny'=> '/etc/hosts.deny'
}
files.each do |key,value|
  cookbook_file value do
    source key
    action :create
    owner 'root'
    mode 0644
  end
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

