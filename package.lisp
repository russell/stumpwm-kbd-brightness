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


(defpackage #:stumpwm.contrib.kbd-brightness
  (:use #:cl)
  (:import-from #:stumpwm
                #:defcommand)
  (:import-from #:dbus
                #:system-server-addresses
                #:with-open-bus
                #:with-introspected-object)
  (:export
   #:get-brightness
   #:set-brightness
   #:max-brightness
   #:*keyboard-brightness-display*))
