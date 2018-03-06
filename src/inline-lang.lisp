(defpackage inline-lang
  (:use :cl)
  (:export #:enable-inline-syntax))
(in-package :inline-lang)

(defvar *previous-readtables* nil)

(defun |##-reader| (stream sub-char numarg)
  (declare (ignore sub-char numarg))
  (let ((symbol (read-line stream))
        chars)
    (do ((prev (read-char stream) curr)
         (curr (read-char stream) (read-char stream)))
        ((and (char= prev #\#) (char= curr #\#)))
      (push prev chars))
    (list (let ((*package* (find-package :inline-lang))
                (*read-eval* nil))
            (read-from-string symbol))
          (or *compile-file-pathname*
              *load-pathname*)
          (coerce (nreverse chars) 'string))))

(defun %enable-inline-syntax ()
  (setf *readtable* (copy-readtable))
  (set-dispatch-macro-character #\# #\# #'|##-reader|))

(defmacro enable-inline-syntax ()
  '(eval-when (:compile-toplevel :load-toplevel :execute)
    (%enable-inline-syntax)))
