#!/usr/bin/awk -f

function dump_table(name, filename)
{
    cmd = "echo :" name " >> " filename
    cmd | getline
    cmd = "iptables -S -v -t " name " >> " filename
    cmd | getline
}

function add_arg(filename)
{
    ARGV[ARGC++] = filename
}

BEGIN {
    STATS_F = "/tmp/iptables-stats.txt"
    INDICIES_F = "/tmp/iptables-stats-indicies.txt"
    SORTED_F = "/tmp/iptables-stats-sorted.txt"

    # Start from clean slate
    print "" > INDICIES_F
    print "" > STATS_F
    print "" > SORTED_F
    
    dump_table("raw", STATS_F)
    dump_table("nat", STATS_F)
    dump_table("filter", STATS_F)

    line = 0
    last_table = ""

    add_arg(STATS_F)
    add_arg(INDICIES_F)
    add_arg(SORTED_F)

    printf "------------|------------|----------|----------------------------\n"
    printf " Packets    | Bytes      | Table    | Rule\n"
    printf "------------|------------|----------|----------------------------\n"
}
{
    if (FILENAME == STATS_F) {
        line++

        pkts[line] = 0
        bytes[line] = 0
        rule[line] = ""
        table[line] = last_table

        if ($1 ~ /^:.*/) {
            last_table = substr($1, 2)
            next
        } 

        for (i = 1; i <= NF; i++) {
            if ($(i) == "-c") {
                pkts[line] = $(i + 1)
                bytes[line] = $(i + 2)
                i += 2
            } else {
                if (rule[line] != "") {
                    rule[line] = rule[line] " " $i
                } else {
                    rule[line] = $i
                }
            }
        }

        if (pkts[line] < 1 || bytes[line] < 1) {
            next
        }

        cmd = "echo " line " " pkts[line] " " bytes[line] " >> " INDICIES_F
        cmd | getline
    }

    if (FILENAME == INDICIES_F) {
        cmd = "sort -r -n -k2,3 " INDICIES_F " -o " SORTED_F
        cmd | getline
        nextfile
    }
        
    if (FILENAME == SORTED_F) {
        if ($1 != "") {
            printf " %10d | %10d | %-8s | %s\n", pkts[$1], bytes[$1], table[$1], rule[$1]
        }
    }
}
