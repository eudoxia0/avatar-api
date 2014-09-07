(in-package :cl-user)
(defpackage avatar-api-test
  (:use :cl :fiveam))
(in-package :avatar-api-test)

(def-suite gravatar)
(in-suite gravatar)

(test gravatar
  (is (equal (avatar-api:gravatar "jdoe@initech.com")
             "http://www.gravatar.com/avatar/6aef61d98ad63bd1aaa89345eb150df2"))
  (is (equal (avatar-api:gravatar "jdoe@initech.com" 25)
             "http://www.gravatar.com/avatar/6aef61d98ad63bd1aaa89345eb150df2?s=25")))

(test tumblr
  (is (equal (avatar-api:tumblr "my-blog.tumblr.com")
             "http://api.tumblr.com/v2/blog/my-blog.tumblr.com/avatar"))
  (is (equal (avatar-api:tumblr "my-blog.tumblr.com" 24)
             "http://api.tumblr.com/v2/blog/my-blog.tumblr.com/avatar/24"))
  (signals avatar-api:wrong-size (avatar-api:tumblr "blog" 25)))

(run! 'gravatar)
(run! 'tumblr)
