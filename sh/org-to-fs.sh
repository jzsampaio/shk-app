#!/bin/bash

find . -name "*.org" -print0 | xargs -0 -I{} -n1 -P 4 emacs --batch --load sh/batch-init.el --eval '(org-babel-tangle-file "{}")'
