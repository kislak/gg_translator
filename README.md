# GgTranslator

Command Line Translator

## Installation

    $ gem install gg_translator

## Usage
    $ gg
    > from en
    > into de
    > hello
    [some output]
    > world
    [some output]
    >+hello world
    [some output]
    >-hello world
    [some output]
    > exit


commands:

* from [en|ru|de|etc...] -- set source language
* into [en|ru|de|etc...] -- set destination language
* exp  -- show usage context.
* exit
* + -- set phrase mode
* - -- set word mode

## Contributing

[https://github.com/kislak/gg_translator](https://github.com/kislak/gg_translator)

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
