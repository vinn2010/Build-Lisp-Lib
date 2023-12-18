#! /bin/bash

qlDirFound() {
  [ -d ~/quicklisp/local-projects ] || failNotFound "fail" "[ -d ~/quicklisp/local-projects ]"
}









# load shunit2
# . ../shunit2/shunit2
. shunit2
