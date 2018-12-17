require "file_utils"
require "ecr"
require "html"

module EmailOpener
  class Message
    DEFAULT_LOCATION = File.join("tmp", "email_opener")

    getter html_part : String,
      text_part : String,
      subject : String,
      from : String,
      to : String,
      cc : String,
      bcc : String,
      reply_to : String,
      location : String

    def initialize(@html_part, @text_part, @subject, from, to, cc = nil, bcc = nil, reply_to = nil, @location = DEFAULT_LOCATION)
      @from = normalize(from)
      @to = normalize(to)
      @cc = normalize(cc)
      @bcc = normalize(bcc)
      @reply_to = normalize(reply_to)
    end

    # ATM renders only html part
    def render
      FileUtils.mkdir_p(location)
      File.open(filepath, "w") { |f| f.puts page }
    end

    def filepath
      File.join(location, "rich.html")
    end

    def page
      ECR.render("#{__DIR__}/templates/default.ecr")
    end

    private def normalize(value : String)
      value
    end

    private def normalize(value : Array)
      value.join(", ")
    end

    private def normalize(value : Nil)
      ""
    end

    private def type
      "rich"
    end

    private def h(text)
      HTML.escape(text)
    end
  end
end
