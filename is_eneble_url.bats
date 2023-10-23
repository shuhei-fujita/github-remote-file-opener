#!/usr/bin/env bats

setup() {
  # リモートリポジトリのURLを取得
  remote_url=$(git remote get-url origin)
  
  # ユーザー名とリポジトリ名を抽出
  usern_name=shuhei_fujita
  repo_name=github-remote-file-opener
  
  # 現在のブランチ名を取得
  branch_name=$(git symbolic-ref --short HEAD)
}

# Test Case 1
@test "Open README.md in current directory with ./" {
  run bash github-repo-open-file ./README.md
  [ "$status" -eq 0 ]
  [[ "${lines[4]}" == "Current Branch: $branch_name" ]]
  [[ "${lines[6]}" == "File Path: README.md" ]]
  [[ "${lines[8]}" == "Final URL: https://github.com/$usern_name/$repo_name/blob/$branch_name/README.md" ]]
}

# Test Case 2
@test "Open README.md in current directory without ./" {
  run bash github-repo-open-file README.md
  [ "$status" -eq 0 ]
  [[ "${lines[4]}" == "Current Branch: $branch_name" ]]
  [[ "${lines[6]}" == "File Path: README.md" ]]
  [[ "${lines[8]}" == "Final URL: https://github.com/$usern_name/$repo_name/blob/$branch_name/README.md" ]]
}

# Test Case 3
@test "Open README.md in subdirectory with ./" {
  cd src/subdirectory
  run bash github-repo-open-file ./README.md
  [ "$status" -eq 0 ]
  [[ "${lines[4]}" == "Current Branch: $branch_name" ]]
  [[ "${lines[6]}" == "File Path: src/subdirectory/README.md" ]]
  [[ "${lines[8]}" == "Final URL: https://github.com/$usern_name/$repo_name/blob/$branch_name/src/subdirectory/README.md" ]]
}

# Test Case 4
@test "Open README.md in subdirectory without ./" {
  cd src/subdirectory
  run bash github-repo-open-file README.md
  [ "$status" -eq 0 ]
  [[ "${lines[4]}" == "Current Branch: $branch_name" ]]
  [[ "${lines[6]}" == "File Path: src/subdirectory/README.md" ]]
  [[ "${lines[8]}" == "Final URL: https://github.com/$usern_name/$repo_name/blob/$branch_name/src/subdirectory/README.md" ]]
}
