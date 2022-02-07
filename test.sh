#!/bin/bash

assert() {
  expected="$1"
  input="$2"

  ./mcc "$input" > tmp.s
  cc -o tmp tmp.s
  ./tmp
  actual="$?"

  if [ "$actual" = "$expected" ]; then
    echo "$input => $actual"
  else
    echo "$input => $expected expected, but got $actual"
    exit 1
  fi
}

assert 0 0
assert 42 42

assert 21 "5+20-4"
assert 6 "30-20-4"
assert 0 "0"
assert 12 "1+1+2+3+5"

assert 41 " 12 + 34 - 5 "
assert 12 "     12   "
assert 5 " 4    + 1 "

echo OK