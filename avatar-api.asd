(in-package :cl-user)
(defpackage avatar-api-asd
  (:use :cl :asdf))
(in-package :avatar-api-asd)

(defsystem avatar-api
  :version "0.1"
  :author "Fernando Borretti"
  :license "MIT"
  :depends-on (:crypto-shortcuts
               :drakma
               :cl-json)
  :components ((:module "src"
                :components
                ((:file "avatar-api"))))
  :description "Get avatars from Gravatar, Google+ and others."
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.md"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op avatar-api-test))))
