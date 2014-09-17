;;; Adjust keyboard brightness.
;;;
;;; Copyright 2013 Russell Sim <russell.sim@gmail.com>
;;;
;;; This module is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3, or (at your option)
;;; any later version.
;;;
;;; This module is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this software; see the file COPYING.  If not, see
;;; <http://www.gnu.org/licenses/>.

(in-package #:stumpwm.contrib.kbd-brightness)

(defvar *keyboard-brightness-display* nil)

(defmacro with-kbd-backlight ((backlight) &body body)
  `(with-introspected-object (,backlight "/org/freedesktop/UPower/KbdBacklight" "org.freedesktop.UPower")
     ,@body))

(defun get-brightness (backlight)
  (funcall backlight "org.freedesktop.UPower.KbdBacklight" "GetBrightness"))

(defun max-brightness (backlight)
  (funcall backlight "org.freedesktop.UPower.KbdBacklight" "GetMaxBrightness"))

(defun set-brightness (backlight value)
  (funcall backlight "org.freedesktop.UPower.KbdBacklight" "SetBrightness" value))

(defcommand kbd-brightness (inc) ((:number "Adjust brightness: "))
  "adjust the keyboard brightness."
  (with-future (future)
      (with-kbd-backlight (backlight)
        (alet* ((current (get-brightness #'backlight))
                (max (max-brightness #'backlight))
                (min 0)
                (new (let ((possible-value (+ current inc)))
                       (cond
                         ((not (plusp possible-value)) min)
                         ((> possible-value max) max)
                         (t possible-value)))))
          (alet ((f (set-brightness #'backlight new)))
            (declare (ignore f))
            (finish future
             (when *keyboard-brightness-display*
               (message "Keyboard Brightness: ~d%" (round (* (/ new max) 100))))))))))
