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
  'auditd.conf'=> '/etc/audit/auditd.conf',
  'system-auth'=> '/etc/pam.d/system-auth',
  'login.defs'=> '/etc/login.defs',
  'bashrc'=> '/etc/bashrc',
  'issue.net'=> '/etc/issue.net',
  'issue'=> '/etc/issue'
}
files.each do |key,value|
  cookbook_file value do
    source key
    action :create
  end
end

['/etc/cron.monthly','/etc/crontab','/etc/cron.hourly','/etc/cron.daily','/etc/cron.weekly','/etc/cron.d'].each do |name|
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
  'hosts.deny'=> '/etc/hosts.deny',
  'passwd'=> '/etc/passwd'
}
files.each do |key,value|
  cookbook_file value do
    source key
    action :create
    owner 'root'
    mode 0644
  end
end

['/sbin/sysctl -w net.ipv4.conf.all.send_redirects=0','/sbin/sysctl -w net.ipv4.route.flush=1','/sbin/sysctl -w net.ipv4.conf.default.send_redirects=0','/sbin/sysctl -w net.ipv4.conf.all.accept_redirects=0','/sbin/sysctl -w net.ipv4.conf.default.accept_redirects=0','/sbin/sysctl -w net.ipv4.conf.all.secure_redirects=0','/sbin/sysctl -w net.ipv4.conf.default.secure_redirects=0','/sbin/sysctl -w net.ipv4.conf.all.log_martians=1','/sbin/sysctl -w net.ipv4.conf.default.log_martians=1'].each do |name|
    execute 'kernel_parameters' do 
      command name 
    end
end

file '/etc/shadow' do
  mode '0000'
  owner 'root'
  group 'root'
end