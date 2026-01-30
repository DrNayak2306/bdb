NC='\033[m'
BLUE='\033[34m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'

OMIT_BEGIN_STR="{ :"
OMIT_END_STR="} &>/dev/null"

omit_begin() {
    printf "${OMIT_BEGIN_STR}\n${OMIT_END_STR}\n" > $DBG_FILE
}

omit_end_reposition() {
    sed -i "/^$(echo $OMIT_END_STR | sed 's|/|\\/|g')$/d" $DBG_FILE
    printf "${OMIT_END_STR}\n" >> $DBG_FILE
}

increment_buf() {
    next_cmd=$1
    buf="$buf; $next_cmd"
}

display_buf() {
    echo "$buf" | grep -Po ":[;] \K.*"
}

flush_buf() {
    buf=":"
}

fetch_src_line() {
    lno=$1
    line=$(head -$i $SRC_FILE | tail -1)
    echo "$line"
}

show_cmd_args() {
    cmd_head=$1
    echo $(grep -Po "$cmd_head \K.*" <<<"$cmd")
}

show_src_line() {
    lno=$1
    line="$2"
    printf "${GREEN}%d\t%s${NC}\n" $i "$line"
}

show_prompt_string() {
    printf "${YELLOW}>>>${NC} "
}

show_cmd_err() {
    printf "${RED}Invalid command. Enter h for help.\n${NC}"
}

show_cmd_help() {
    printf "${BLUE}Available commands:
q : quit
p : print cumulative file
b [d] [e] [f]: buffer [display (default)] [execute] [flush]
n [w] [e]: next command [write to buffer (default)] [execute]
d [VAR1] [VAR2] ... : display values of VAR1, VAR2, etc..
${NC}"
}
