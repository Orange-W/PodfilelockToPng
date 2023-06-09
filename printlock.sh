#!/bin/bash
IFS=''
file=${1:-"Podfile.lock"}
output=${2:-"output.dot"}

disableSubLine=0
onlyName=''

while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -i|--input)
        file="$2"
        shift # past argument
        shift # past value
        ;;
        -o|--output)
        output="$2"
        shift # past argument
        shift # past value
        ;;
        -n|--no_sub)
        disableSubLine=1
        shift # past argument
        ;;
        --only)
        onlyName="$2"
        shift # past argument
        shift # past value
        ;;
        *)    # unknown option
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
done

[[ -n "$onlyName" ]] && disableSubLine=0

A=''
B=''

# 重置内容
echo 'digraph demo {' > $output
echo 'node [color=lightblue2, style=filled];' >> $output
# echo 'rankdir = LR' >> $output
echo 'ranksep = 3;' >> $output
# echo 'main[shape=box];' >> $output


while read line
do
  # 读取到 DEPENDENCIES 为止
  [[ $line =~ "DEPENDENCIES:" ]] && break

  # 必须包含 ’-‘ 才解释
  [[ $line =~ "-" ]] || continue

  # 切割数组
  OLD_IFS="$IFS"
  IFS=' '
  array=($line)
  count=$(echo "$line" | awk '{str=length($0); sub(/^[ ]*/,"",$0); print str-length($0);}')
  
  # 确定依赖与被依赖对象
  if [[ $line =~ ":" || $count -eq "2" ]] ; then
    A=${array[1]}

#     [[ -n "$onlyName" && "$A" != "$onlyName" ]] && continue  # 只解析指定名称的依赖
    [[ disableSubLine -eq 1 && $A =~ "/" ]] && continue # 不显示子组件依赖
    echo '"'$A'"[shape=box]' >> $output
  else
    B=${array[1]}
    [[ disableSubLine -eq 1 && ($B =~ "/" || $A =~ "/") ]] && continue # 不显示子组件依赖

    lineColor="green"
    style="bold"

    if [[ $A != '' ]]; then
      [[ $B =~ "/" || $A =~ "/" ]] && lineColor="black" && style="dotted"
#       [[ -n "$onlyName" && "$A" != "$onlyName" ]] && continue  # 只解析指定名称的依赖
      echo '"'$A'"'  '->'  "\"$B\"[color=$lineColor, shape=box, style=$style]" >> $output
    else 
      echo '"'$B'"[shape=box]' >> $output
    fi
  fi

  IFS="$OLD_IFS"

done < $file

echo '}' >> $output

dot  -v $output  -T png -o $output.png
