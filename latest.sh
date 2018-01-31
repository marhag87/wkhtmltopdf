#!/bin/bash
# Script for checking for new versions of wkhtmltopdf
# Written by Martin Hagström 2018-01-31

set -e

update=false
name=wkhtmltopdf

function getlatestversion() {
  curl -s 'https://api.github.com/repos/wkhtmltopdf/wkhtmltopdf/releases/latest' | awk -F'"' '/tag_name/ {print $4}'
}

function getcurrentversion() {
  awk '/^Version/ { print $2 }' SPECS/${name}.spec
}

function update() {
  datestring=$(date "+%a %b %d %Y Martin Hagstrom <marhag87@gmail.com> $1-1")
  sed -i "s/\(^Version:\s*\)[[:digit:].]*/\1${1}/"   SPECS/${name}.spec
  sed -i "s/\(^Release:\s*\)[[:digit:].]*/\11/"      SPECS/${name}.spec
  sed -i "s/\%changelog/\%changelog\n\* ${datestring}\n- Update to $1/" SPECS/${name}.spec
}

function compareversions() {
  latestversion=$(getlatestversion)
  currentversion=$(getcurrentversion)
  if [[ $currentversion != $latestversion ]]; then
    if [[ $update == true ]]; then
      update $latestversion
    else
      echo "${name} not up to date, latest version: ${latestversion}"
    fi
  fi
}

while getopts ":u" opt; do
  case $opt in
    u)
      update=true
      shift
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

compareversions
