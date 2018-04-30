#!/usr/local/bin/ruby

require 'rubygems'
require 'fog'


connection = Fog::Storage.new(:provider => "AWS",
                              :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                              :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])

directory = connection.directories.new(:key => ARGV[0])
directory.files.create(:body => File.open(ARGV[1], 'rb'),
                       :key => File.basename(ARGV[1]),
                       :public => true)

puts "http://#{ARGV[0]}.s3.amazonaws.com/#{File.basename(ARGV[1])}"
