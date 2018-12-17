require "spec"

require "carbon"

require "../src/email_opener"
require "../src/email_opener/carbon_adapter"

def build_message(
    html = "html",
    text = "text",
    subject = "subject",
    from = "from",
    to = "to"
  )
  EmailOpener::Message.new(html, text, subject, from, to)
end

Spec.before_each do
  FileUtils.rm_rf("tmp")
end
