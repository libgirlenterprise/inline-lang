(defpackage inline-lang
  (:use :cl)
  (:export #:enable-inline-syntax))
(in-package :inline-lang)

(defvar *previous-readtables* nil)

(defun module (symbol)
  (let ((*read-eval* nil))
    (asdf:load-system (format nil "inline.~(~A~)" symbol))
    (read-from-string (format nil "inline.~(~A~)::~(~A~)" symbol symbol))))

(defun |##-reader| (stream sub-char numarg)
  (declare (ignore sub-char numarg))
  (let* ((symbol (read-from-string (read-line stream)))
         chars)
    (do ((prev (read-char stream) curr)
         (curr (read-char stream) (read-char stream)))
        ((and (char= prev #\#) (char= curr #\#)))
      (push prev chars))
    (list (module symbol)
          (or *compile-file-pathname*
              *load-pathname*)
          (coerce (nreverse chars) 'string))))

(defun %enable-inline-syntax ()
  (setf *readtable* (copy-readtable))
  (set-dispatch-macro-character #\# #\# #'|##-reader|))

(defmacro enable-inline-syntax ()
  '(eval-when (:compile-toplevel :load-toplevel :execute)
    (%enable-inline-syntax)))
