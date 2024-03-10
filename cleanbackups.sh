cd backups && ls | grep -v .gitkeep | xargs rm -rf &> /dev/null && cd .. || exit 0
