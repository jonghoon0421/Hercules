# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    find_peeps.rb                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jonkim <jonkim@student.42.us.org>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/03/09 18:23:35 by jonkim            #+#    #+#              #
#    Updated: 2018/03/09 21:24:22 by jonkim           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

require 'oauth2'

UID = ENV['MY_UID']
SECRET = ENV['MY_SEC']
if !UID or !SECRET
	puts "Error : failed to get application credentials."
	return 0
end
if ARGV.length >= 2
	puts "Error : only up to one argument is allowed."
	return 0
end
# create the client with the credentials
client = OAuth2::Client.new(UID, SECRET, site: "https://api.intra.42.fr")
# get an access token
token = client.client_credentials.get_token
if !token
	puts "Error : failed to get an access token."
	return 0
end
if ARGV.length == 1 and File.exist?(ARGV[0])
	File.readlines(ARGV[0]).each do |login|
		login = login.strip
		begin
			response = token.get("/v2/users/#{login}/locations")
			until response.status == 200
				puts "API is not responding... please wait..."
				sleep(1);
				if response.status == 200
					puts "API!"
					break ;
				end
			end
			if response.parsed[0]["end_at"]
				puts "#{login} is off-line.\n"
			else
				puts "#{login} : #{response.parsed[0]["host"]}\n"
			end
		rescue
			puts "#{login} is not a registered user.\n"
		end
	end
elsif ARGV.length == 0
	until false
		print "login : "
		begin
			login = gets().strip
		rescue
			return 0
		end
		begin
			if login == "Exit -y"
				return 0
			end
			response = token.get("/v2/users/#{login}/locations")
			until response.status == 200
				puts "API is not responding... please wait..."
				sleep(1)
				if response.status == 200
					puts "API!"
					break ;
				end
			end
			if response.parsed[0]["end_at"]
				puts "#{login} is off-line.\n"
			else
				puts "#{login} : #{response.parsed[0]["host"]}\n"
			end
		rescue
			puts "#{login} is not a registered user.\n"
		end
	end
else
	puts "invalid file name."
end
