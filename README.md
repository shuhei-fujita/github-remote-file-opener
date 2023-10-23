# github-remote-file-opener

- `github-remote-file-opener` は、ローカルのGitリポジトリにある特定のファイルやディレクトリを、GitHub上のURLで開くためのコマンドラインツールです。
- このスクリプトは、現在のブランチの最新のコミットに基づいてURLを生成します。
- ファイルがsubmodule内にある場合も対応しています。

## インストール

### ソースコードのクローン

まず、このリポジトリをクローンします。

```bash
git clone git@github.com:shuhei-fujita/github-remote-file-opener.git
cd github-remote-file-opener
```

### Makefileを使用したインストール

- このリポジトリには Makefile が含まれており、簡単なインストールが可能です。
- このコマンドは、github-repo-open-file.sh スクリプトに実行権限を付与し、~/bin ディレクトリにコピーします。

※ `~/bin`がPATH環境変数に含まれていることを確認してください。
※ そうでない場合は、`.bashrc`、`.zshrc` などのシェル設定ファイルに`export PATH=$PATH:~/bin`を追加してください。

```bash
make install
```

## 使い方

基本的な使い方は以下の通りです。

```bash
github-repo-open-file [相対ファイルパス]
```

例）
現在のリポジトリのルートディレクトリで以下のコマンドを実行すると、対応するGitHubのURLがブラウザで開きます。

```bash
github-repo-open-file ./github-repo-open-file.sh
```

```bash
github-repo-open-file ./README.md
```

```bash
github-repo-open-file ./index.html
```

```bash
github-repo-open-file ./src/index.html
```
