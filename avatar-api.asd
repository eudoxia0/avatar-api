(in-package :cl-user)
(defpackage avatar-api-asd
  (:use :cl :asdf))
(in-package :avatar-api-asd)

(defsystem avatar-api
  :version "0.1"
  :author "Fernando Borretti"
  :license "MIT"
  :homepage "https://github.com/eudoxia0/avatar-api"
  :depends-on (:crypto-shortcuts
               :drakma
               :cl-json)
  :components ((:module "src"
                :components
                ((:file "avatar-api"))))
  :description "Get avatars from Gravatar, Google+ and others."
  :long-description
  #.(uiop:read-file-string
     (uiop:subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op avatar-api-test))))
