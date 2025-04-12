#!/usr/bin/env fish

# Check if a target server (user@host:path) is provided as an argument
if test -z "$argv[1]"
  echo "Usage: $argv[0] <user@host:destination_path>"
  echo "Example: $argv[0] user@example.com:/home/user/backup"
  return 1
end

set TARGET "$argv[1]"

# Loop through all directories in the current directory
for item in */
  if test -d "$item"
    set FOLDER_NAME (basename "$item") # Get folder name without trailing slash
    echo "Copying folder: $FOLDER_NAME to $TARGET"
    scp -r "$FOLDER_NAME" "$TARGET"
    if test $status -eq 0
      echo "Successfully copied: $FOLDER_NAME"
    else
      echo "Error copying: $FOLDER_NAME"
    end
  end
end

echo "Finished processing directories."

