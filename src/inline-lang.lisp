(defpackage inline-lang
  (:use :cl)
  (:export #:enable-inline-reader
	   #:disable-inline-reader
	   #:define-lang
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

(defmacro define-lang (name program-str)
  (let ((gcode-str (gensym "code-str")))
    `(defun ,name (,gcode-str)
       (let ((code-stream (make-string-input-stream ,gcode-str)))
	 (uiop:run-program ,program-str
			   :input code-stream
			   :output *standard-output*)))))

(define-lang node "node")
