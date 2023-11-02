#!/bin/bash

cd ~/quicklisp/local-projects

# Read project name from stdin
echo "What is the name of your lisp library? "
read project
clear

# Make folder structure
mkdir $project

# create all files
touch $project/$project.asd
touch $project/$project.lisp
touch $project/package.lisp
touch $project/Makefile

# ASDF File
# ASDF is setup for executable creation
bash -c "cat > $project/$project.asd" << EndOfMessage
(asdf:defsystem :$project
  :version "0.0.1"
  :author "Kevin Izevbigie"
  :license ""
  :description ""
  :depends-on (:hunchentoot
	             :cl-who
	             :clsql
	             :clsql-postgresql
	             :markdown.cl
	             :jonathan
	             :dexador
	             :delay)
  :serial t
  :components (
	       (:file "package")
	       (:file "$project"))
  ;; for building the binary
  :build-operation "asdf:program-op"
  :build-pathname "run-app"
  :entry-point "$project:main")

EndOfMessage

# package file
bash -c "cat > $project/package.lisp" << EndOfMessage
(in-package :cl-user)
(defpackage :$project
 (:use :cl))
EndOfMessage

# main file
bash -c "cat > $project/$project.lisp" << EndOfMessage
(in-package :$project)
EndOfMessage

# make file
bash -c "cat > $project/Makefile" << EndOfMessage
build:
  sbcl --load $project.asd \
       --eval '(ql:quickload :$project)' \
       --eval '(compile-file "~/quicklisp/local-projects/$project/$project.lisp")' \
       --eval '(load "~/quicklisp/local-projects/$project/$project.lisp")' \
       --eval '(asdf:make :$project)' \
       --eval '(quit)'
EndOfMessage

echo -e "\033[32m Your project is created"
