;;; xonsh-mode.el --- Major mode for editing xonshrc files -*- lexical-binding: t; -*-

;; Copyright (C) 2019  Sean Farley

;; Author: Sean Farley <sean@farley.io>
;; URL: https://github.com/seanfarley/xonsh-mode
;; Keywords: languages
;; Version: 0
;; Package-Requires: ((emacs "24.3"))

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

;; This package implements a major mode to edit xonshrc files. The basic
;; functionality includes:
;;
;;    - Syntax highlight for xonsh operators
;;
;; Files with the .xonshrc or .xsh extension are automatically opened with
;; this mode.


;;; Code:

(require 'python)

(defvar xonsh-font-lock-keywords
  `(;; new keywords in xonsh language
    (,(regexp-opt '("xontrib" "load") 'words)
     1 font-lock-keyword-face)
    ;; C and Python types (highlight as builtins)
    (,(regexp-opt '("aliases") 'words)
     1 font-lock-builtin-face)
    ;; $ENV business
    (,(rx (* (any " \t"))
          (group "\$" (1+ (or word ?_
                              (0+ "." (1+ (or word ?_)))))))
     (1 font-lock-type-face)))
  "Additional font lock keywords for xonsh mode.")

;;;###autoload
(define-derived-mode xonsh-mode python-mode "xonsh"
  "Major mode for xonsh, derived from Python mode.
\\{xonsh-mode-map}"
  (setcar font-lock-defaults
          (append xonsh-font-lock-keywords
                  (if (boundp 'python-font-lock-keywords-maximum-decoration)
                      python-font-lock-keywords-maximum-decoration
                    python-font-lock-keywords))))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.xsh\\'" . xonsh-mode))
;;;###autoload
(add-to-list 'auto-mode-alist '("\\.xonshrc\\'" . xonsh-mode))
;;;###autoload
(add-to-list 'auto-mode-alist '("xonshrc" . xonsh-mode))

(provide 'xonsh-mode)
;;; xonsh-mode.el ends here
