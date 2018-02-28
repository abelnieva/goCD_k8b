#
# Cookbook:: gocd_test
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'apt'
include_recipe 'gocd_test::setup_ruby'
include_recipe 'gocd_test::setup_docker'
include_recipe 'gocd_test::setup_terraform'
include_recipe 'gocd_test::setup_gcloud_sdk'
include_recipe 'gocd_test::setup_app'
include_recipe 'gocd_test::configure_app'
