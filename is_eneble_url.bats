## Batsテストコードの再チェック

以下は、各テストケース（1, 2, 3, 4, 5, 6）に対応するBats（Bash Automated Testing System）を使用したテストコードの例です。

```bash
#!/usr/bin/env bats

setup() {
  # リモートリポジトリのURLを取得
  remote_url=$(git remote get-url origin)
  
  # ユーザー名とリポジトリ名を抽出
  dummy_user=$(echo $remote_url | sed -n 's/.*github.com:\(.*\)\/\(.*\).git/\1/p')
  dummy_repo=$(echo $remote_url | sed -n 's/.*github.com:\(.*\)\/\(.*\).git/\2/p')
  
  # 現在のブランチ名を取得
  dummy_branch=$(git symbolic-ref --short HEAD)
  
  # テスト用のディレクトリを作成
  mkdir -p src/common
  mkdir -p src/submodule
}

# Test Case 1
@test "Open README.md in current directory with ./" {
  run bash github-repo-open-file ./README.md
  [ "$status" -eq 0 ]
  [[ "${lines[4]}" == "Current Branch: $dummy_branch" ]]
  [[ "${lines[6]}" == "File Path: README.md" ]]
  [[ "${lines[8]}" == "Final URL: https://github.com/$dummy_user/$dummy_repo/blob/$dummy_branch/README.md" ]]
}

# Test Case 2
@test "Open README.md in current directory without ./" {
  run bash github-repo-open-file README.md
  [ "$status" -eq 0 ]
  [[ "${lines[4]}" == "Current Branch: $dummy_branch" ]]
  [[ "${lines[6]}" == "File Path: README.md" ]]
  [[ "${lines[8]}" == "Final URL: https://github.com/$dummy_user/$dummy_repo/blob/$dummy_branch/README.md" ]]
}

# Test Case 3
@test "Open README.md in subdirectory with ./" {
  cd src/common
  run bash github-repo-open-file ./README.md
  [ "$status" -eq 0 ]
  [[ "${lines[4]}" == "Current Branch: $dummy_branch" ]]
  [[ "${lines[6]}" == "File Path: src/common/README.md" ]]
  [[ "${lines[8]}" == "Final URL: https://github.com/$dummy_user/$dummy_repo/blob/$dummy_branch/src/common/README.md" ]]
}

# Test Case 4
@test "Open README.md in subdirectory without ./" {
  cd src/common
  run bash github-repo-open-file README.md
  [ "$status" -eq 0 ]
  [[ "${lines[4]}" == "Current Branch: $dummy_branch" ]]
  [[ "${lines[6]}" == "File Path: src/common/README.md" ]]
  [[ "${lines[8]}" == "Final URL: https://github.com/$dummy_user/$dummy_repo/blob/$dummy_branch/src/common/README.md" ]]
}

# Test Case 5
@test "Open README.md in submodule directory with ./" {
  cd src/submodule
  run bash github-repo-open-file ./README.md
  [ "$status" -eq 0 ]
  [[ "${lines[4]}" == "Current Branch: $dummy_branch" ]]
  [[ "${lines[6]}" == "File Path: src/submodule/README.md" ]]
  [[ "${lines[8]}" == "Final URL: https://github.com/$dummy_user/$dummy_repo/blob/$dummy_branch/src/submodule/README.md" ]]
}

# Test Case 6
@test "Open README.md in submodule directory without ./" {
  cd src/submodule
  run bash github-repo-open-file README.md
  [ "$status" -eq 0 ]
  [[ "${lines[4]}" == "Current Branch: $dummy_branch" ]]
  [[ "${lines[6]}" == "File Path: src/submodule/README.md" ]]
  [[ "${lines[8]}" == "Final URL: https://github.com/$dummy_user/$dummy_repo/blob/$dummy_branch/src/submodule/README.md" ]]
}
