bash 'installgcloud' do
  code <<-EOH
   wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-190.0.1-linux-x86_64.tar.gz
   tar -xvzf google-cloud-sdk-190.0.1-linux-x86_64.tar.gz
   ./google-cloud-sdk/install.sh --usage-reporting=false --quiet
    EOH
end
include_recipe 'kubectl::default'
