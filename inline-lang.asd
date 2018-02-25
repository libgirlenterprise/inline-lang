#|
  This file is a part of inline-lang project.
  Copyright (c) 2018 Shaka Chen (scchen@libgirl.com)
|#

#|
  Author: Shaka Chen (scchen@libgirl.com)
|#

(defsystem "inline-lang"
  :version "0.1.0"
  :author "Shaka Chen"
  :license "LLGPL"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "inline-lang"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "inline-lang-test"))))
