# DpkgControlParser
Parse Debian control file.

This Ruby script will parse Debian control file into both Ruby objects
and JSON string.

## Usage
```ruby
DpkgControlParser.parse([controlfile]) => controlhash [Hash(Hash(Array))]
DpkgControlParser.printAsJson([controlhash]) => [nil]
```

## Example
- Get [Rails control file from Debian Salsa](https://salsa.debian.org/ruby-team/rails/raw/master/debian/control) and print as JSON format.
  ```ruby
  require 'open-uri'
  require './dpkg-control-parser'

  open "https://salsa.debian.org/ruby-team/rails/raw/master/debian/control" do |controlfile|
      DpkgControlParser.printAsJson(DpkgControlParser.parse(controlfile))
  end
  ```

## License
- Expat
  ```
  Copyright (c) 2019 Jongmin Kim

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the
  "Software"), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:

  The above copyright notice and this permission notice shall be included
  in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ```
