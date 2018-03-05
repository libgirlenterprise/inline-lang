(defpackage inline-lang
  (:use :cl)
  (:export #:enable-inline-reader
	   #:disable-inline-reader
	   #:node))
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
          (coerce (nreverse chars) 'string))))


;; will replace with named-readtable
(defun enable-inline-reader ()
  (push *readtable* *previous-readtables*)
  (setf *readtable* (copy-readtable))
  (set-dispatch-macro-character #\# #\# #'|##-reader|))

(defun disable-inline-reader ()
  (setf *readtable* (or (pop *previous-readtables*)
                        *readtable*)))

(defun node (code-str)
  (let ((code-stream (make-string-input-stream code-str)))
    (uiop:run-program "node"
		      :input code-stream
		      :output *standard-output*)))
