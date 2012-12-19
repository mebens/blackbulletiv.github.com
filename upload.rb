#!/usr/bin/env ruby
require "net/ftp"
require "ptools"

def process(file)
  path = "_site/#{file}"
  existed = File.exists?("_oldsite/#{file}")
  
  if File.directory?(path)
    unless existed
      begin
        $ftp.mkdir(file)
      rescue Net::FTPPermError => e
        raise unless e.message[0, 3].to_i == 550 # error code
      end
      
      print "#{file}\n" unless $quiet
    end
    
    Dir.foreach(path) { |f| process("#{file}/#{f}") if path_ok?(f) }
  else
    upload_file = !existed
    
    if existed
      `diff #{path} _oldsite/#{file}`
      upload_file = $? != 0
    end
    
    if upload_file
      if File.binary?(path)
        $ftp.putbinaryfile(path, file)
      else
        $ftp.puttextfile(path, file)
      end
      
      print "#{file}\n" unless $quiet
    end
  end
end

def path_ok?(path)
  not $ignore.include?(path) || path =~ $page_regex
end

def upload
  $ignore = [".", "..", ".DS_STORE", ".DS_Store"]
  $page_regex = /^page\d+$/
  $quiet = ARGV[0] == "-q"
  $ftp_info = IO.readlines("ftp-info.txt")

  $ftp = Net::FTP.new($ftp_info[0].chomp, $ftp_info[1].chomp, $ftp_info[2].chomp)
  $ftp.chdir($ftp_info[3].chomp)
  Dir.foreach("_site") { |file| process(file) if path_ok?(file) }
  $ftp.close
  print "Site uploaded\n"
end

upload if $0 == __FILE__
