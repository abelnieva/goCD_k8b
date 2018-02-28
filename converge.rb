#! /usr/bin/env ruby

# usage: ./converge-prod.rb path/to/env.tfvars
#
# env.tfvars *must* exist


require 'pathname'


pathname = Pathname.new(ARGV[0]).realpath
puts "path: #{pathname}"
raise "Env tfvars doesn't exist at #{ARGV[0]}" unless pathname.file?
action=ARGV[1]
action2=ARGV[2]
env=File.basename(ARGV[0]).chomp(".tfvars")
stack=pathname.to_s.split('/').pop(2)[0]
puts "env: #{env} stack: #{stack}"

case action
when "init"
  puts "####Terraform Init####"
  cmd = "terraform init kubernetes_deploy/"
  puts "cmd: #{cmd}"
  status=system(cmd)
  puts "status: #{status}"
when "create"
  puts "####Create####"
  cmd = "terraform apply -var=\"env=#{env}\" -var=\"stack=#{stack}\" -var-file=\"#{pathname}\" kubernetes_deploy/"
  puts "cmd: #{cmd}"
  status=system(cmd)
  puts "status: #{status}"
when "destroy"
  puts "####Destroy####"
  cmd = "terraform destroy -var=\"env=#{env}\" -var=\"stack=#{stack}\" -var-file=\"#{pathname}\" kubernetes_deploy/"
  puts "cmd: #{cmd}"
  status=system(cmd)
  puts "status: #{status}"
when "apps"
        case action2
        when "list"
                puts "####List apps####"
                files = Dir.glob(File.join("./apps/", "*"))
                files.each do |file|
                  puts file.to_s.split("/").pop(1)
                end
                action=true
        when "install"
              puts "####installing apps####"
              raise "no apps provided" unless !ARGV[3].to_s.empty?
              pathname_app = Pathname.new("./apps/#{ARGV[3]}/kubernetes-deploy.sh").realpath
              raise "#{ARGV[3] }app does not exist" unless pathname_app.file?
              cmd = "bash -c \"./apps/#{ARGV[3]}/kubernetes-deploy.sh #{stack} #{env}\""
              puts "cmd: #{cmd}"
              status=system(cmd)
              puts "status: #{status}"
        when "deploy"
              puts "####deploying apps####"
              raise "no apps provided" unless !ARGV[3].to_s.empty?
              pathname_app = Pathname.new("./apps/#{ARGV[3]}/kubernetes-deploy.sh").realpath
              raise "#{ARGV[3] }app does not exist" unless pathname_app.file?
              cmd = "bash -c \"./apps/#{ARGV[3]}/kubernetes-deploy.sh #{stack} #{env} --deploy-only \""
              puts "cmd: #{cmd}"
              status=system(cmd)
              puts "status: #{status}"
        else
            puts "#{action2} : uknown option"
        end
else
  puts "#{action} : uknown option"
end

if status == true
  puts "action: #{action} have been completed sucessfully"
else
  puts "action: #{action} have NOT been completed sucessfully"
end
