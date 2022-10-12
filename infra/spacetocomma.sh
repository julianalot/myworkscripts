sed -e 's/^[ \t]*// ; s/[[:blank:]]*$// ; s/\s\+/,/g ; s/,$//' input-file-name | tee output-file-name
