git_client 'default' do
  action :install
end

git '/home/chefuser/goCD_kb8' do
  repository 'https://github.com/abelnieva/goCD_k8b.git'
  revision 'master'
  user 'chefuser'
  action :checkout
end

cookbook_file '/home/chefuser/goCD_kb8/credentials.json' do
  source 'credentials.json'
  owner 'chefuser'
  group 'chefuser'
  mode '0755'
  action :create
end

bash 'chown' do
  code <<-EOH
   sudo chown -R chefuser /home/chefuser/goCD_kb8/
    EOH
end
