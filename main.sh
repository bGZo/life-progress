#!/bin/bash

# +-------------------------------+
# | Project: Output Life Progress |
# +-------------------------------+

# 将字符串转换为日期
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

# 计算年龄（年和月）
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

# 输出带颜色的行
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

# 接收参数，默认为今天
target_date=${1:-$(date +"%Y-%m-%d")}

# 生日
my_birthday="2001-08-07"
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