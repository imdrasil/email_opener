module EmailOpener
  class SystemInformation
    enum OS
      Linux
      OSX
      Windows
    end

    def self.operating_system
      @@operating_system ||=
        begin
          name = system_name
          if name == "Linux"
            OS::Linux
          elsif name == "Darwin"
            OS::OSX
          elsif name == "Windows_NT" || name =~ /CYGWIN_NT\-/
            OS::Windows
          else
            raise ArgumentError.new("Unknown operating system - #{name}")
          end
        end
    end

    def self.launchy
      case operating_system
      when OS::Linux
        "xdg-open"
      when OS::OSX
        "open"
      else # Windows
        "start"
      end
    end

    def self.open_file(path)
      `#{launchy} #{path}`
    end

    private def self.system_name
      `uname -s`.chomp
    end
  end
end
