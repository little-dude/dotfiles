;;; flycheck-virtualenv.el --- Setup Flycheck by Virtualenv  -*- lexical-binding: t; -*-

;; Copyright (C) 2013-2016  Sebastian Wiesner <swiesner@lunaryorn.com>

;; Author: Sebastian Wiesner <swiesner@lunaryorn.com>
;; Keywords: tools, convenience

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Setup Flycheck according to the current virtualenv.
;;
;; Enable with:
;;
;; (add-hook 'python-mode-hook #'flycheck-virtualenv-setup)

;; This file was taken from
;; https://github.com/lunaryorn/old-emacs-configuration/blob/2dcb6bb4b0a50bd6b8b02b0070463ed95096d70e/lisp/flycheck-virtualenv.el
;; See also: https://github.com/flycheck/flycheck/issues/692

;;; Code:

(require 'flycheck)

;; We can safely declare this function, since we'll only call it in Python Mode,
;; that is, when python.el was already loaded.
(declare-function python-shell-calculate-exec-path "python")

(defun flycheck-virtualenv-executable-find (executable)
  "Find an EXECUTABLE in the current virtualenv if any."
  (if (bound-and-true-p python-shell-virtualenv-root)
      (let ((exec-path (python-shell-calculate-exec-path)))
        (executable-find executable))
    (executable-find executable)))

(defun flycheck-virtualenv-setup ()
  "Setup Flycheck for the current virtualenv."
  (setq-local flycheck-executable-find #'flycheck-virtualenv-executable-find))

(provide 'flycheck-virtualenv)

;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:

;;; flycheck-virtualenv.el ends here
