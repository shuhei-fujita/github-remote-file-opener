# Bats（Bash Automated Testing System）を使用してのテスト

## テストケース

1. テストケース：カレントディレクトリ
github-repo-open-file ./README.md

2. テストケース：カレントディレクトリ
github-repo-open-file README.md

3. テストケース：サブディレクトリがあるか確認して、サブディレクトリがある場合はサブディレクトリ
github-repo-open-file ./README.md

4. テストケース：サブディレクトリがあるか確認して、サブディレクトリがある場合はサブディレクトリ
github-repo-open-file README.md

5. テストケース：サブディレクトリがあるか確認して、サブディレクトリがある場合かつそのサブディレクトリがサブモジュールの場合
github-repo-open-file ./README.md

6. テストケース：サブディレクトリがあるか確認して、サブディレクトリがある場合かつそのサブディレクトリがサブモジュールの場合
github-repo-open-file README.md

## Batsの実行方法

Bats（Bash Automated Testing System）を使用してテストを実行するには、以下の手順を参考にしてください。

1. Batsのインストール: もしまだBatsがインストールされていない場合は、以下のようにしてインストールできます。

```bash
git clone https://github.com/bats-core/bats-core.git
cd bats-core
sudo ./install.sh /usr/local
```

または、パッケージマネージャを使用してインストールすることもできます。例えば、Homebrewを使用している場合は以下のようにします。

```bash
brew install bats-core
```

2. テストファイルの作成: `is_eneble_url.bats` のような `.bats` 拡張子を持つファイルを作成します。

3. テストの実行: テストを実行するには、ターミナルで以下のコマンドを実行します。

```bash
bats is_eneble_url.bats
```

4. 結果の確認: テストが成功したかどうかは、出力される結果を確認してください。

setup()で必要なディレクトリを作成し、teardown()で後処理をしています。
