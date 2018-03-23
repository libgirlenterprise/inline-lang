;; ros -l test-read.lisp
(asdf:load-asd (merge-pathnames "../inline-lang.asd" (make-pathname :name nil :type nil :defaults *load-pathname* )))
(ql:quickload :inline-lang)
(inline-lang:enable-inline-reader)
(format t "~S~%"
 (with-open-file (in *load-pathname*)
   (loop with eof = (gensym) 
         for i = (read in nil eof)
         until (eql i eof)
         collect i)))

(uiop:quit)

(1)



##node

something written in node here.



##
(2)
(3)

