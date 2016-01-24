require 'bundler'
require 'debugger'
require 'active_support'
require 'active_support/all'
# Bundler.require

module CleanseIPs
  def self.cleanse()
    file = "/home/root/allowedIPs.list"
    contents = File.read(file)
    currDate = Time.now

    output = ""
    contents.each_line do |line|
      # p line
      if line.split.length >= 3 
        date = Time.strptime(line.split[2], "%d-%m-%Y//%H:%M")
        if( !date.nil? ) 
          if !((currDate - date ) > 7.days )
            # p "Want to delete this line:"
            p line
            output = output + line
          end
        end
      end
    end
    File.write(file, output)
  end
end

CleanseIPs.cleanse()