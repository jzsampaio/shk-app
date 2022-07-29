#!/bin/bash

if [ -z "$(which inotifywait)" ]; then
    echo "inotifywait not installed."
    echo "In most distros, it is available in the inotify-tools package."
    exit 1
fi

counter=0;

function execute() {
    echo "Running org-babel-tangle on $1 ..."
    emacs --batch --load sh/batch-init.el --eval "(org-babel-tangle-file \"$1\")"
}

inotifywait --recursive --monitor --format "%w%f" \
--event move,create,close_write ./src-org \
| while read changed; do
    execute "$changed"
done
