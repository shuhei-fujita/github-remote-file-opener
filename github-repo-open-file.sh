#!/bin/bash

# 引数からファイルの相対パスを取得
file_path="$1"

# 引数が指定されていない場合はエラーメッセージを表示
if [ -z "$file_path" ]; then
  echo "Error: Please specify a valid relative file path."
  exit 1
fi

# Get the root directory of the main repository
repo_root=$(git rev-parse --show-toplevel)

# Identify the submodule path if it exists
submodule_path=$(git submodule status | awk '{print $2}' | while read -r line; do
  if [[ "$file_path" == "$line"* ]]; then
    echo "$line"
    break
  fi
done)

# If the file is in a submodule, navigate to it
if [ ! -z "$submodule_path" ]; then
  cd "$repo_root/$submodule_path" || exit 1
  file_path=${file_path#"$submodule_path/"}
fi

# Get the remote URL and commit hash
remote_url=$(git remote get-url origin)
commit_hash=$(git rev-parse HEAD)

# Extract the GitHub username and repository name
user_and_repo=$(echo $remote_url | sed -n 's/.*github.com:\(.*\).git/\1/p')

# Generate the final URL
final_url="https://github.com/$user_and_repo/blob/$commit_hash/$file_path"

# Debugging Information
echo "---------------------"
echo "Debugging Information"
echo "Remote URL: $remote_url"
echo "Commit Hash: $commit_hash"
echo "File Path: $file_path"
echo "Final URL: $final_url"

# プラットフォームを判別
case "$(uname -s)" in
  Darwin)
    # macOS
    open $final_url
    ;;
  Linux)
    # Linux
    xdg-open $final_url
    ;;
  CYGWIN*|MINGW32*|MSYS*|MINGW*)
    # Windows
    start $final_url
    ;;
  *)
    # 未知のプラットフォーム
    echo "Unknown OS, cannot open URL automatically."
    ;;
esac
