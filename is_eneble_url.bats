#!/usr/bin/env bats

# デバッグ用の関数
debug_output() {
  echo "Debug: The value of status is: $status"
  echo "Debug: The value of lines[3] is: ${lines[3]}"
  echo "Debug: The value of lines[4] is: ${lines[4]}"
  echo "Debug: The value of lines[5] is: ${lines[5]}"
  echo "Debug: The value of branch_name is: $branch_name"
}

setup() {
  # リモートリポジトリのURLを取得
  remote_url=$(git remote get-url origin)
  
  # ユーザー名とリポジトリ名を抽出
  usern_name=shuhei-fujita
  repo_name=github-remote-file-opener
  
  # 現在のブランチ名を取得
  branch_name=$(git symbolic-ref --short HEAD)
}

# Test 1
@test "Open \"./README.md\" in current directory" {
  run bash github-repo-open-file ./README.md
  debug_output
  [ "$status" -eq 0 ]
  [[ "${lines[3]}" == "Current Branch: $branch_name" ]]
  [[ "${lines[4]}" == "File Path: README.md" ]]
  [[ "${lines[5]}" == "Final URL: https://github.com/$usern_name/$repo_name/blob/$branch_name/README.md" ]]
}

# Test 2
@test "Open \"README.md\" in current directory" {
  run bash github-repo-open-file README.md
  debug_output
  [ "$status" -eq 0 ]
  [[ "${lines[3]}" == "Current Branch: $branch_name" ]]
  [[ "${lines[4]}" == "File Path: README.md" ]]
  [[ "${lines[5]}" == "Final URL: https://github.com/$usern_name/$repo_name/blob/$branch_name/README.md" ]]
}

# Test 3
@test "Open \"./README.md\" in subdirectory directory \"src/subdirectory\"" {
  cd src/subdirectory
  run bash github-repo-open-file ./README.md
  debug_output
  [ "$status" -eq 0 ]
  [[ "${lines[3]}" == "Current Branch: $branch_name" ]]
  [[ "${lines[4]}" == "File Path: src/subdirectory/README.md" ]]
  [[ "${lines[5]}" == "Final URL: https://github.com/$usern_name/$repo_name/blob/$branch_name/src/subdirectory/README.md" ]]
}

# Test 4
@test "Open \"README.md\" in subdirectory directory \"src/subdirectory\"" {
  cd src/subdirectory
  run bash github-repo-open-file README.md
  debug_output
  [ "$status" -eq 0 ]
  [[ "${lines[3]}" == "Current Branch: $branch_name" ]]
  [[ "${lines[4]}" == "File Path: src/subdirectory/README.md" ]]
  [[ "${lines[5]}" == "Final URL: https://github.com/$usern_name/$repo_name/blob/$branch_name/src/subdirectory/README.md" ]]
}
