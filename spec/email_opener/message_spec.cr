require "../email_opener_spec"

describe EmailOpener::Message do
  described_class = EmailOpener::Message

  describe ".new" do
    it do
      described_class.new("html", "text", "subject", ["from"], "to").tap do |message|
        message.from.should eq("from")
        message.cc.should eq("")
      end
    end
  end

  describe "#render" do
    it "creates html file" do
      build_message.render
      File.exists?("tmp/email_opener/rich.html").should be_true
    end

    pending "creates txt file"
  end

  describe "#filepath" do
    it do
      build_message.filepath.should eq("tmp/email_opener/rich.html")
    end
  end

  describe "#page" do
    it "includes subject" do
      build_message(subject: "__subject__").page.should match(/__subject__/)
    end

    it "includes html in srdoc" do
      build_message(html: "<html>custom html</html>").page.should match(/<iframe seamless="seamless" srcdoc="<base target='_top'>&lt;html&gt;custom html&lt;\/html&gt;"><\/iframe>/)
    end
  end
end
