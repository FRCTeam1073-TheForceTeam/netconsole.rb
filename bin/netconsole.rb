require 'socket'
require 'thread'
#set this to your team number
TEAM = "1073"
#UDP ports for NetConsole
IN = 6666
OUT = 6668

#function to print UDP packets from the cRio
def receiveData
	listener = UDPSocket.new
	listener.bind(nil, IN)
	while true do 
		print listener.recvfrom(16)[0]
	end
end
#function to send UDP 
def sendData
	sender = UDPSocket.new
	while true do
		input = gets.chompn << "\r\n"
		sender.send(input, 0, teamIP, OUT)
	end
end

t1 = Thread.new {receiveData}
t2 = Thread.new {sendData}

t1.join
t2.join

#returns IP address of the cRio
def teamIP
	return nil unless TEAM.match /\d\d\d\d/
	ip = "10." << TEAM[0,2] << "." << TEAM[2,3] << ".2"
end
