require "./abstract_adapter"

module EmailOpener
  class CarbonAdapter < Carbon::Adapter
    include AbstractAdapter

    def deliver_now(email : Carbon::Email)
      __deliver__(build_message(email))
    end

    private def build_message(email)
      Message.new(
        email.html_body || "",
        email.text_body || "",
        email.subject,
        parse_address(email.from),
        parse_addresses(email.to),
        parse_addresses(email.cc),
        parse_addresses(email.bcc),
        reply_to(email)
      )
    end

    private def reply_to(email)
      header = email.headers.find { |k, v| k.downcase == "reply-to" }
      header && header[1] || ""
    end

    private def parse_address(address : Carbon::Address)
      format_address(address.name, address.address)
    end

    private def parse_address(address : String)
      parse_address(address.carbon_address)
    end

    private def parse_addresses(addresses : Array)
      addresses.map { |address| parse_address(address) }
    end
  end
end
