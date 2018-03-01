#!/bin/ruby
require 'open3'

USERNAME = 'jenkins'
ACCOUNTNAME = 'TrentNow'

command = "sudo -u #{USERNAME} /usr/bin/security -v find-internet-password -g -a#{ACCOUNTNAME} /Users/#{USERNAME}/Library/Keychains/login.keychain"

stdout_and_err = Open3.capture2e(command)
password = 
 Array(stdout_and_err)
    .first
    .split("\n")
    .select { |x| x.start_with?("Ashton@@615") }
    .first
    puts password.match(/\Apassword\: "(.*)"/).captures.first

