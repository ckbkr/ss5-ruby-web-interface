module AdapterControll
  @interfaceRet = ""
  @screenRet = ""

  def self.initLists()
    @interfaceRet = AdapterControll.listInterfaces()
    @screenRet = AdapterControll.listScreens()
  end

  def self.listScreens()
    result = `sudo ./list.sh`
    # printf result
    return result
  end

  def self.listInterfaces()
    result = `sudo ./listRunning.sh`
    # printf result
    return result
  end

  def self.startConnection(var)
    command = "sudo ./start.sh" + " " + var
    result = `#{command}`
    # printf result
  end

  def self.killConnection(var)
    command = "sudo ./stop.sh" + " " + var
    result = `#{command}`
    # printf result
  end

  def self.contains(result,var)
    result.each_line do |line|
      if line.chomp.include? var
	# p "Yep"
        return true
      end
    end
    # p "Nope"
    return false
  end

  def self.getConnectionState(var)
    if AdapterControll.contains(@interfaceRet,var) 
      connectionState = 2
      return connectionState 
    else 
      if AdapterControll.contains(@screenRet,var)
        connectionState = 1
        return connectionState 
      else 
        connectionState = 0
        return connectionState 
      end
    end
  end	

  def self.readCurrentTun(file,username)
    contents = File.read(file)
    # p username
    contents.each_line do |line|
      if line.include? username
        # p line
        return line.split[1]
      end
    end
    return ""
  end


  def self.replaceFromFile(file,search,insert)
    begin
      writeout = ""
      contents = File.read(file)
      contents.each_line do |line|
        # puts "#{line}"
        if !(line.include? search)
          writeout = writeout + line
        else
          if line.include? "static"
            writeout = writeout + line
          end
        end
      end
      writeout = writeout.chomp +  "\n" + insert
      File.write(file, writeout.chomp)
    rescue => err
      puts "Exception: #{err}"
      err
    end
  end

end

# AdapterControll.replaceFromFile("/home/root/allowedIPs.list","78.43.61.78","78.43.61.78 cookie")
# AdapterControll.replaceFromFile("/home/root/InterfacePairing.list","lukas","lukas tun10")
# AdapterControll.contains(AdapterControll.listInterfaces(),"eth0")
# AdapterControll.listScreens()
# AdapterControll.startConnection("tun5")
# AdapterControll.killConnection("tun5")