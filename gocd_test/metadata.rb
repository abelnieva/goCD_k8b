name 'gocd_test'
maintainer 'Abel Nieva'
maintainer_email 'abelnieva at gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures gocd_test'
long_description 'Installs/Configures gocd_test'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/gocd_test/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/gocd_test'

depends 'docker', '~> 4.0.1'
depends 'terraform', '~> 1.0.2'
depends 'docker_compose', '~> 0.0'
depends 'kubectl', '~> 0.1.1'
depends 'git', '~> 8.0.1'
depends 'apt'
