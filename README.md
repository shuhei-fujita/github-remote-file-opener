# github-remote-file-opener

- `github-remote-file-opener` は、ローカルのGitリポジトリにある特定のファイルやディレクトリを、GitHub上のURLで開くためのコマンドラインツールです。
- このスクリプトは、現在のブランチの最新のコミットに基づいてURLを生成します。
- ファイルがsubmodule内にある場合も対応しています。

## インストール

1. `open-remote-repo.sh` スクリプトをクローンします。

```bash
git clone \
    git@github.com:shuhei-fujita/github-remote-file-opener.git \
    && cd github-remote-file-opener \
```

2. スクリプトに実行権限を付与します。

```bash
chmod +x ./open-remote-repo.sh
```

3. シンボリックリンクを作成して、、どこのディレクトリからでもコマンドとして利用できるようにします。

```bash
ln -s ./open-remote-repo.sh ~/bin/open-remote-repo
```

**注意:** `~/bin` が `PATH` 環境変数に含まれていることを確認してください。

## 使い方

基本的な使い方は以下の通りです。

```bash
open-remote-repo [相対ファイルパス]
```

例）
現在のリポジトリのルートディレクトリで以下のコマンドを実行すると、対応するGitHubのURLがブラウザで開きます。

```bash
open-remote-repo ./open-remote-repo.sh
```

```bash
open-remote-repo ./README.md
```

```bash
open-remote-repo ./index.html
```

```bash
open-remote-repo ./src/index.html
```
