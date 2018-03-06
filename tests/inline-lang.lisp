(defpackage inline-lang/test
  (:use :cl
        :inline-lang
        :prove))
(in-package :inline-lang/test)

;; NOTE: To run this test file, execute `(asdf:test-system :inline-lang)' in your Lisp.

(plan nil)

(inline-lang:enable-inline-syntax)

(is (read-from-string "##c
something written in node here.
##
")
    `(,(read-from-string "INLINE.C/SRC/C::C") NIL "something written in node here.
"))

(finalize)
