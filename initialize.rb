require './adapterControll'


module Initialize
  Choices = { }  

  def self.initChoices  
    AdapterControll.initLists()	
    File.readlines('pingResults.txt').map do |line|
      key, value, ping =  line.chomp.split("::")
      connectionState = AdapterControll.getConnectionState(key)
      Choices[key] = [ value + " : " + ping, connectionState ]
    end
    Choices.sort
    return Choices
  end

  def self.initTun(username)
    currentTun = AdapterControll.readCurrentTun("/home/root/InterfacePairing.list",username)
    return currentTun
  end
end

# Initialize.init()
