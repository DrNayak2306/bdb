#!/usr/bin/env bash

SRC_FILE=$1
DBG_FILE=/tmp/`basename $1`.dbg

show_src_line() {
    printf "\033[032m%d\t%s\033[m\n" $i "$line"
}

show_prompt_string() {
    printf "\033[33m>>>\033[m "
}

touch $DBG_FILE
chmod +x $DBG_FILE
printf "#!/usr/bin/env bash\n{ :\n" > $DBG_FILE

for ((i=1; i<$(wc -l $SRC_FILE | cut -d ' ' -f 1); )); do
    show_prompt_string
    read cmd
    case "$cmd" in
        p)
            head -$i $SRC_FILE
            ;;
        n)
            ((i++))
            line=$(head -$i $SRC_FILE | tail -1)
            sed -i '/^}>\/dev\/null$/d' $DBG_FILE
            printf "}>/dev/null\n" >> $DBG_FILE
            printf "%s\n" "$line" >> $DBG_FILE
            show_src_line
            $DBG_FILE
            ;;
        "exit")
            break
            ;;
        *)
            echo "Wrong command"
            ;;
    esac
done

