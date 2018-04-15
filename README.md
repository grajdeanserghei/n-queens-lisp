# N-Queens problem in LISP with GUI 

This is a toy project in which I explore LISP. It is a desktop application written in LISP. For GUI [Tcl/Tk](http://www.peter-herth.de/ltk/ltkdoc-single/) library is used.


![alt text](https://github.com/grajdeanserghei/n-queens-lisp/blob/master/docs/images/intermediate_solution.png "GUI")

## Getting Started

### Prerequisites

#### Libraries
For GUI [LTK - a Lisp binding to the Tk toolkit](http://www.peter-herth.de/ltk/ltkdoc-single/) is required.

Standard installation of [tcl/tk](https://www.activestate.com/activetcl/downloads) is required. 

#### EMACS install instructions
1. Install [EMACS](https://www.gnu.org/software/emacs/download.html)
2. [Steel Bank Common Lisp](http://www.sbcl.org/platform-table.html)
3. Download [Quciklisp](https://www.quicklisp.org/beta/) and put it in home directory. Run in cmd `sbcl --load quicklisp.lisp`
 Follow instructions. 
 * run `(ql:add-to-init-file)` to 
4. Install Slime by running `(ql:quickload "quicklisp-slime-helper")` in lisp cmd (smcl)
 * create `.emacs` file in your lisp home directory.
 * copy 
 ```
  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "sbcl")
  ```
  from console and add it to `.emacs` file
5. To add package to asdf run ` (push #p"/projects/my-project/" asdf:*central-registry*)` in lisp console.

###

