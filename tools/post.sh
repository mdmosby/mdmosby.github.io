#!/usr/bin/env bash
#
# create a new draft post with the specified title

# use an array to preserve the command and its parts
command() {
  bundle exec jekyll $1 $2
}

help() {
  echo "Usage:"
  echo
  echo "   bash /path/to/post create TITLE"
  echo "   bash /path/to/post publish TITLE"
  echo "   bash /path/to/post unpublish TITLE"
  echo
  echo "Options:"
  echo "     -h, --help           Print this help information."
  echo
  echo "Notes:"
  echo "     TITLE should be the title of the post without timestamp or extension."
}

title=""
subcommand=""

# Argument handling: accept exactly one positional argument or -h/--help
case "$#" in
2)
  case "$1" in
  -h | --help)
    help
    exit 0
    ;;
  -*)
    echo -e "> Unknown option: '$1'\n"
    help
    exit 1
    ;;
  *)
    subcommand="$1"
    title="$2"
    ;;
  esac
  ;;
*)
  help
  exit 1
  ;;
esac

case "$subcommand" in
"create")
  command "draft" "$title"
  $EDITOR "_drafts/$title.md"
  ;;
"publish")
  command "publish" "_drafts/$title.md"
  ;;
"unpublish")
  command "unpublish" "_posts/*$title.*"
  ;;
*)
  echo -e "> Unknown subcommand: '$subcommand'\n"
  help
  exit 1
  ;;
esac
