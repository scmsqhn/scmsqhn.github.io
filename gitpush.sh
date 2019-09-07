#!/bin/expect


set timeout 60
spawn git add ./** 
spawn git commit -m 'add'
spawn git push -f origin master
expect "name"
send "scmsqhn\r"

expect "word"
send "githubscmsqhn161229\r"

set timeout 3
expect "master"
send "git diff\r"

interact
