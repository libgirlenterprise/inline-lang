#|
  This file is a part of inline-lang project.
  Copyright (c) 2018 Shaka Chen (scchen@libgirl.com)
|#

(defsystem "inline-lang-test"
  :defsystem-depends-on ("prove-asdf")
  :author "Shaka Chen"
  :license "LLGPL"
  :depends-on ("inline-lang"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "inline-lang"))))
  :description "Test system for inline-lang"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
