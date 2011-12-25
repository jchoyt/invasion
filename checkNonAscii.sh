#! /bin/bash
find src -type f  | xargs grep -Pn "[\x80-\xFF]"
find html -type f | xargs grep -Pn "[\x80-\xFF]" | grep -v jquery | grep -v "Binary file "
find config -type f  | xargs grep -Pn "[\x80-\xFF]"
