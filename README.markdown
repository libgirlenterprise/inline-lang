# Inline-Lang

## Usage
TO use inline reader.
```common-lisp
(inline-lang:enable-inline-reader)
;=> t

##foo "bar" baz##
;=> "foo \"bar\" baz"

```

To use node.js commands.
```common-lisp
(inline-lang:enable-inline-reader)
;=> t

(inline-lang:node
##
var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\n');
}).listen(3000);

console.log('Server running at http://localhost:3000/');
##)


```
TO access your local host. (http://localhost:3000).


## Installation

1. Clone to your local-projects.
```common-lisp
cd $HOME/quicklisp/local-projects
git clone https://github.com/libgirlenterprise/inline-lang.git

```

2. Start your lisp. Then, jsut:
```common-lisp
(ql:quickload :cl-webcam)

```

## Author

* Shaka Chen (scchen@libgirl.com)

## Copyright

Copyright (c) 2018 Shaka Chen (scchen@libgirl.com)

## License

Licensed under the LLGPL License.
