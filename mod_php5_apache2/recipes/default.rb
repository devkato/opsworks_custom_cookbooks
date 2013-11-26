include_recipe 'apache2'

packages = []

case node[:platform]
when 'debian', 'ubuntu'
  packages = [
    'php5-xsl',
    'php5-curl',
    'php5-xmlrpc',
    'php5-sqlite',
    'php5-dev',
    'php5-gd',
    'php5-cli',
    'php5-sasl',
    'php5-mysql',
    'php5-mcrypt',
    'php5-memcache',
    'php-pear',
    'php-xml-parser',
    'php-mail-mime',
    'php-db',
    'php-mdb2',
    'php-html-common'
  ]

when 'centos', 'redhat', 'fedora', 'amazon'
  # TODO: Compile php-sqlite extension for RHEL based systems.
  packages = [
    'php54-xml',
    'php54-common',
    'php54-xmlrpc',
    'php54-devel',
    'php54-gd',
    'php54-cli',
    #'php-pear-Auth-SASL',
    'php54-mysql',
    'php54-mcrypt',
    'php54-pecl-memcache',
    'php54-mbstring',
    'php54-pdo',
    'php54-pecl-apc',
    'php54-pecl-apc-devel',
    #'php-pear',
    #'php-pear-XML-Parser',
    #'php-pear-Mail-Mime',
    #'php-pear-DB',
    #'php-pear-HTML-Common'
  ]
end

packages.each do |pkg|
  package pkg do
    action :install
  end
end

include_recipe 'apache2::mod_php5'

# install AWS SDK
# @TODO import php_pear php_pear_channel resource/provider from
# https://github.com/opscode-cookbooks/php
# execute 'autodiscover' do
#   command 'pear -D auto_discover=1 install pear.amazonwebservices.com/sdk; echo "";'
#   action :run
#   user 'root'
# end

#php_pear_channel "pear.amazonwebservices.com" do
#  action :discover
#end
#
#php_pear "aws/sdk" do
#  channel pear.amazonwebservices.com
#  action :install
#end
