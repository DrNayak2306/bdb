NC='\033[m'
BLUE='\033[34m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'

write_omitstr_start_STR="{ :"
OMIT_END_STR="} &>/dev/null"

write_omitstr_start() {
    printf "${write_omitstr_start_STR}\n${OMIT_END_STR}\n" > $DBG_FILE
}

write_omitstr_end() {
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

handle_SIGINT() {
  printf "\nInterrupted.\n"
  exit 130
}

handle_SIGTERM() {
  printf "\nTerminated.\n"
  exit 143
}

exit_with_error() {
  exit 1
}

show_usage() {
  printf "Usage: %s BASHSCRIPT\n" "$0"
  exit 1
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

show_eof() {
  printf "${RED}EOF\n${NC}"
}

source ./help_docs.bash
show_cmd_help() {
    printf "${BLUE}"
    if [ -z $1 ]; then
        printf "Available commands:\n"
        for i in "${!cmds[@]}"; do
          printf "%s\n" "$(head -1 <<<"${cmds[$i]}")"
        done
    else
      printf "%s\n" "${cmds[$1]}"
    fi
    printf "${NC}"
}
