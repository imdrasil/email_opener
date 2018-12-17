require "../email_opener"

module EmailOpener
  module AbstractAdapter
    def __deliver__(message : Message)
      message.render
      SystemInformation.open_file(message.filepath)
    end

    private def format_address(name : String, address)
      "#{name} - #{address}"
    end

    private def format_address(name : Nil, address)
      address
    end
  end
end
