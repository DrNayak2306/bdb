declare -A cmds
cmds[q]=$(cat <<EOF
q : exit
Removes temporary file $SRC_FILE
EOF
)
cmds[g]=$(cat <<EOF
g [e] : global actions
Without argument prints the cumlative list of script lines.
[e] : execute
EOF
)
cmds[b]=$(cat <<EOF
b [e] [f] : buffer actions
Without argument prints the cumulative list of commands in buffer.
[e] : execute
[f] : flush
EOF
)
cmds[s]=$(cat <<EOF
Go to next line of script and write to buffer.
EOF
)
cmds[d]=$(cat <<EOF
d VAR1 [VAR2] ... : display values of VAR1, VAR2, ...
EOF
)
cmds[e]=$(cat <<EOF
e COMMAND : execute COMMAND
Introduce a non-persistent change.
EOF
)

