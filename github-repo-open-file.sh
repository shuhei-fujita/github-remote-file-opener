#!/bin/bash

# 引数からファイルの相対パスを取得
file_path="$1"

# 引数が指定されていない場合はエラーメッセージを表示
if [ -z "$file_path" ]; then
  echo "Error: Please specify a valid relative file path."
  exit 1
fi

# Gitリポジトリのルートディレクトリを取得
repo_root=$(git rev-parse --show-toplevel)

# 絶対パスに変換（macOS対応）
file_path=$(perl -e 'use File::Spec; print File::Spec->abs2rel(@ARGV) . "\n"' "$file_path" "$repo_root")

# 現在のブランチ名を取得
current_branch=$(git symbolic-ref --short HEAD)

# リモートURLとコミットハッシュを取得
remote_url=$(git remote get-url origin)

# GitHubのユーザー名とリポジトリ名を抽出
user_and_repo=$(echo $remote_url | sed -n 's/.*github.com:\(.*\).git/\1/p')

# 最終的なURLを生成
final_url="https://github.com/$user_and_repo/blob/$current_branch/$file_path"

# デバッグ情報
echo "---------------------"
echo "Debugging Information"
echo "Remote URL: $remote_url"
echo "Current Branch: $current_branch"
echo "File Path: $file_path"
echo "Final URL: $final_url"

# プラットフォームを判別してURLを開く
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
