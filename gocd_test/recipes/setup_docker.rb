docker_installation 'default'
bash 'add_to_docker_group' do
  code <<-EOH
  sudo groupadd docker
  sudo usermod -aG docker chefuser
    EOH
end

docker_service 'default' do
  group 'docker'
  action [:create, :start]
end

docker_image "library/hello-world" do
  action :pull
end
docker_container 'hello-world' do
  repo 'library/hello-world'
  tag 'latest'
  action :run
end

include_recipe 'docker_compose::installation'
