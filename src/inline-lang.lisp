(defpackage inline-lang
  (:use :cl)
  (:export #:enable-inline-reader
	   #:disable-inline-reader
	   #:node))
(in-package :inline-lang)

(defvar *previous-readtables* nil)

;;; this segment adapted and modified from https://letoverlambda.com/index.cl/guest/chap4.html#sec_3
(defun |##-reader| (stream sub-char numarg)
  (declare (ignore sub-char numarg))
  (let (chars)
    (do ((prev (read-char stream) curr)
         (curr (read-char stream) (read-char stream)))
        ((and (char= prev #\#) (char= curr #\#)))
      (push prev chars))
    (coerce (nreverse chars) 'string)))

(defun enable-inline-reader ()
  (push *readtable* *previous-readtables*)
  (setf *readtable* (copy-readtable))
  (set-dispatch-macro-character #\# #\# #'|##-reader|))

(defun disable-inline-reader ()
  (setf *readtable* (pop *previous-readtables*)))

(defun node (code-str)
  (let ((code-stream (make-string-input-stream code-str)))
    (uiop:run-program "node"
		      :input code-stream
		      :output *standard-output*)))
