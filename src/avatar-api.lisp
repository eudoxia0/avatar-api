(in-package :cl-user)
(defpackage avatar-api
  (:use :cl)
  (:export :wrong-size
           :gravatar
           :tumblr
           :yahoo
           :google))
(in-package :avatar-api)

;;; Errors

(define-condition wrong-size ()
  ((size :initarg :size :reader size)
   (allowed-sizes :initarg :allowed-size :reader allowed-size))

  (:report
   (lambda (condition stream)
     (format stream "Wrong size for avatar '~A', allowed sizes are: ~A."
             (size condition)
             (allowed-sizes condition)))))

;;; Gravatar

(defun validate-gravatar-size (size)
  (if (and (>= size 1) (<= size 2048))
      t
      (error 'wrong-size :size size :allowed-sizes "from 1 to 2048")))

(defun gravatar (email &optional size)
  (let ((hash (crypto-shortcuts:md5 (string-downcase email))))
    (format nil "http://www.gravatar.com/avatar/~A~A"
            hash
            (if size
                (progn
                  (validate-gravatar-size size)
                  (format nil "?s=~A" size))
                ""))))

;;; Tumblr

(defparameter +tumblr-allowed-sizes+ (list 16 24 30 40 48 64 96 128 512))

(defun validate-tumblr-size (size)
  (if (member size +tumblr-allowed-sizes+)
      t
      (error 'wrong-size :size size :allowed-sizes +tumblr-allowed-sizes+)))

(defun tumblr (base-hostname &optional size)
  (format nil "http://api.tumblr.com/v2/blog/~A/avatar~A"
          base-hostname
          (if size
              (progn
                (validate-tumblr-size size)
                (format nil "/~A" size))
              "")))

;;; Yahoo

(defun yahoo (userid)
  (format nil "http://img.msg.yahoo.com/v1/displayImage/yahoo/~A" userid))

;;; Google (kind of a hack)

(defun json-decode (stream)
  (cl-json:decode-json-from-string
   (flexi-streams:octets-to-string stream)))

(defun google (userid)
  (let ((json (json-decode
               (drakma:http-request
                (format nil "http://picasaweb.google.com/data/entry/api/user/~A?alt=json"
                        userid)))))
    (rest (assoc :$t (rest (assoc :gphoto$thumbnail (rest (assoc :entry json))))))))
