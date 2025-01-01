#!/bin/bash

get_date_from_string() {
    date -d "$1" +"%Y-%m-%d"
}

days_since_birthday() {
    birthday=$(date -d "$1" +"%s")
    target_day=$(date -d "$2" +"%s")
    echo $(( (target_day - birthday) / 86400 ))
}

weeks_since_birthday() {
    days=$(days_since_birthday "$1" "$2")
    echo $(( days / 7 ))
}

months_since_birthday() {
    birthday=$(date -d "$1" +"%Y-%m-%d")
    target_day=$(date -d "$2" +"%Y-%m-%d")

    birth_year=$(date -d "$birthday" +"%Y")
    birth_month=$((10#$(date -d "$birthday" +"%m")))
    birth_day=$((10#$(date -d "$birthday" +"%d")))

    current_year=$(date -d "$target_day" +"%Y")
    current_month=$((10#$(date -d "$target_day" +"%m")))
    current_day=$((10#$(date -d "$target_day" +"%d")))

    years_difference=$(( current_year - birth_year ))
    months_difference=$(( (years_difference * 12) + (current_month - birth_month) ))

    if [ "$current_day" -lt "$birth_day" ]; then
        months_difference=$(( months_difference - 1 ))
    fi
    echo $months_difference
}

age_in_years_and_months() {
    birthday=$(date -d "$1" +"%Y-%m-%d")
    target_day=$(date -d "$2" +"%Y-%m-%d")

    birth_year=$(date -d "$birthday" +"%Y")
    birth_month=$((10#$(date -d "$birthday" +"%m")))
    birth_day=$((10#$(date -d "$birthday" +"%d")))

    current_year=$(date -d "$target_day" +"%Y")
    current_month=$((10#$(date -d "$target_day" +"%m")))
    current_day=$((10#$(date -d "$target_day" +"%d")))

    age_years=$(( current_year - birth_year ))
    age_months=$(( current_month - birth_month ))

    if [ "$current_day" -lt "$birth_day" ]; then
        age_months=$(( age_months - 1 ))
    fi

    if [ "$age_months" -lt 0 ]; then
        age_years=$(( age_years - 1 ))
        age_months=$(( age_months + 12 ))
    fi

    echo "$age_years years and $age_months months"
}

write_colored_line() {
    label=$1
    value=$2
    color=$3

    case $color in
        "Yellow") color_code="\033[1;33m" ;;
        "Cyan") color_code="\033[1;36m" ;;
        *) color_code="\033[0m" ;;
    esac

    reset_color="\033[0m"
    printf "${color_code}| %-10s %-28s |\n" "$label" "$value"
}

## load config birthday
LIFE_PROGRESS_DIR=$(dirname $0)
CONFIG_FILE="$LIFE_PROGRESS_DIR/life-progress.conf"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
fi

my_birthday=${MY_BIRTHDAY:-$(date +"%Y-%m-%d")}

# show help
show_help() {
    echo "Usage: $0 [target_date]"
    echo
    echo "Options:"
    echo "  target_date     end date to calculate, today default"
    echo "                  format could be:"
    echo "                     - 2025/01/01"
    echo "                     - 2025-01-01"
    echo "                     - 20250101"
    echo "  -h              show help"
    echo
    echo "example："
    echo "  $0             # today prompt"
    echo "  $0 2030-01-01  # history prompt"
    exit 0
}

validate_date() {
    local date_regex="^([0-9]{4})([-/])?(0[1-9]|1[0-2])([-/])?(0[1-9]|[12][0-9]|3[01])$"
    if [[ ! $1 =~ $date_regex ]]; then
        show_help
    fi
}

if [ -n "$1" ]; then
    validate_date "$1"
fi

if [ "$1" == "-h" ]; then
    show_help
fi


target_date=${1:-$(date +"%Y-%m-%d")}

days_passed=$(days_since_birthday "$my_birthday" "$target_date")
weeks_passed=$(weeks_since_birthday "$my_birthday" "$target_date")
months_passed=$(months_since_birthday "$my_birthday" "$target_date")
age=$(age_in_years_and_months "$my_birthday" "$target_date")

# 输出进度框
echo -e "\033[1;36m+-----------------------------------------+"
echo -e "|       Your current life progress is     |"
echo -e "|-----------------------------------------+"
write_colored_line "Days  :" "$days_passed" "Yellow"
write_colored_line "Weeks :" "$weeks_passed" "Yellow"
write_colored_line "Months:" "$months_passed" "Yellow"
write_colored_line "Age   :" "$age" "Yellow"
echo -e "+-----------------------------------------+\033[0m"