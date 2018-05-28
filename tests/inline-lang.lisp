(defpackage inline-lang-test
  (:use :cl
        :inline-lang
        :prove))
(in-package :inline-lang-test)

;; NOTE: To run this test file, execute `(asdf:test-system :inline-lang)' in your Lisp.

(setf *enable-colors* nil)

(plan nil)

(enable-inline-reader)

(subtest "inline-reader test"
  (is ##foo "bar" baz## "foo \"bar\" baz"))

(disable-inline-reader)

(finalize)
