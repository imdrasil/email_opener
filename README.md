# Email Opener [![Build Status](https://travis-ci.org/imdrasil/email_opener.svg)](https://travis-ci.org/imdrasil/email_opener) [![Latest Release](https://img.shields.io/github/release/imdrasil/email_opener.svg)](https://github.com/imdrasil/email_opener/releases) [![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://imdrasil.github.io/email_opener/versions)

Preview email in the default browser instead of sending it. This means you don't need to set up email delivery in your development environment, and you no longer need to worry about accidentally sending a test email to someone else's address.

## Installation

1. Add the dependency to your `shard.yml`:
```yaml
dependencies:
  email_opener:
    github: imdrasil/email_opener
```
2. Run `shards install`

## Usage

Depending on used email library you need to implement adapter for `EmailOpener`. ATM this library is delivered with [carbon](https://github.com/luckyframework/carbon) adaptor on the board. Here is simple example of basic carbon base mailer:

```crystal
require "email_opener/carbon_adapter"

MAILER_ADAPTER = EmailOpener::CarbonAdapter.new

abstract class ApplicationMailer < Carbon::Email
  getter email_subject : String, email_address : String

  from Carbon::Address.new("Sample App", "noreply@sample-app.com")
  to email_address
  subject email_subject
  settings.adapter = MAILER_ADAPTER

  def initialize
    @email_address = ""
    @email_subject = ""
  end
end
```

After email is sent HTML part is written to `./tmp/email_opener/rich.html` and opened by default browser.

## Development

To implement own adapter include `EmailOpener::AbstractAdapter` module and invoke in a delivery method `#__deliver__` passing `EmailOpener::Message` with all information regarding email.

```crystal
require "email_opener/abstract_adapter"

class OwnAdapter < SomeLibrary::Adapter
  include EmailOpener::AbstractAdapter

  def deliver(email)
    __deliver__(
      EmailOpener::Message.new(
        email.html_body,
        email.text_body,
        email.subject,
        email.from,
        mail.to,
        email.cc,
        email.bcc,
        email.reply_to
      )
    )
  end
end
```

## Contributing

1. Fork it (<https://github.com/imdrasil/email_opener/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Roman Kalnytskyi](https://github.com/imdrasil) - creator and maintainer

This library is inspired by ruby library [letter_opener](https://github.com/ryanb/letter_opener).
