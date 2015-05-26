(in-package :cl-user)
(defpackage avatar-api-test-asd
  (:use :cl :asdf))
(in-package :avatar-api-test-asd)

(defsystem avatar-api-test
  :author "Fernando Borretti"
  :license "MIT"
  :description "Tests for avatar-api"
  :depends-on (:avatar-api :fiveam)
  :components ((:module "t"
                :components
                ((:file "avatar-api")))))
