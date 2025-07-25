# Rust CLI Kiln - 設計思想

**重要**: このドキュメントとプロジェクトに関するすべてのやりとりは日本語で行うこと。Claude Codeとの対話も必ず日本語を使用する。

## 概要

このドキュメントは、複数のRust CLIツールを効率的に開発・管理するための設計思想と構成について説明します。

## リポジトリ構成

### 共通コードリポジトリ (.github)

`.github` リポジトリは、複数のRust CLIプロジェクト間で共有される共通コードを集約する場所です。各CLIプロジェクトは、このリポジトリの内容をシンボリックリンクとしてマウントして使用します。

### ディレクトリ構造

```
2025/
├── .github/          # 共通コードリポジトリ
├── diffx/           # CLI プロジェクト 1
├── diffai/          # CLI プロジェクト 2
└── lawkit/          # CLI プロジェクト 3
```

## クローンルール

すべてのリポジトリは同じ親ディレクトリ内に横並びでクローンする必要があります：

```bash
cd ~/repos/2025
git clone [共通リポジトリURL] .github
git clone [diffxリポジトリURL] diffx
git clone [diffaiリポジトリURL] diffai
git clone [lawkitリポジトリURL] lawkit
```

## シンボリックリンクによる共通コードの利用

各CLIプロジェクトは、`.github` リポジトリ内の共通コードをシンボリックリンクでマウントして使用します。これにより：

- コードの重複を避ける
- 一箇所で修正すれば全プロジェクトに反映される
- 各プロジェクトは独立したリポジトリとして管理できる

## 同期の考え方

1. **共通コードの更新**: `.github` リポジトリで行う
2. **プロジェクト固有の実装**: 各CLIプロジェクトのリポジトリで行う
3. **バージョン管理**: 各プロジェクトは独立してバージョン管理されるが、共通コードの互換性に注意が必要

## プロジェクト構成

### 各CLIプロジェクトの共通構造

3つのプロジェクト（diffx、diffai、lawkit）は、ほぼ同じフォルダ構成を持っています。主な違いは、引数・オプションなどの機能面です。

```
プロジェクト名/
├── プロジェクト名-cli/      # Rust CLI実装
├── プロジェクト名-core/     # Rustコアライブラリ（他言語から利用可能）
├── プロジェクト名-python/   # Python バインディング（pip パッケージ）
├── プロジェクト名-npm/      # JavaScript バインディング（npm パッケージ）※
├── README.md               # プロジェクト固有のドキュメント
├── docs/                   # プロジェクト固有の詳細ドキュメント
└── tests/                  # プロジェクト固有のテストコード
```

※ 注意: npm版のフォルダ名は現在 `-npm` ですが、ライブラリ名は `-js` になっています。将来的にはフォルダ名も `-js` に統一する予定です。

### ビルド成果物

各プロジェクトは以下の4つの成果物を生成します：

1. **CLIバイナリ**: `プロジェクト名-cli` からビルド
2. **Rustコアクレート**: `プロジェクト名-core` からビルド（他言語バインディングの基盤）
3. **Pythonパッケージ**: `プロジェクト名-python` からビルド（PyPIに公開）
4. **JavaScriptパッケージ**: `プロジェクト名-js` としてnpmに公開（フォルダは現在 `-npm`）

### プロジェクト固有の要素

以下の要素は各プロジェクトで異なります：

- コマンドライン引数とオプション
- 機能の実装詳細
- README.md の内容
- docs/ 配下のドキュメント
- テストコード

## リリース手順の共通化

### 背景

複数のプロジェクトを安定してリリースしていくためには、手順の共通化が必須です。そのため、共通の手順やツールを `.github` リポジトリに集約しています。

### .github リポジトリの特別な役割

GitHubにおいて `.github` という名前のリポジトリは特別な意味を持ち、組織内の全リポジトリで共通のコードやテンプレートを配置できます。この特性を活用して、以下の共通リソースを管理しています：

1. **GitHub Actions ワークフロー**: 各プロジェクトで共通のCI/CDパイプライン
2. **シェルスクリプト**: ワークフローから呼び出される共通のビルド・テストスクリプト
3. **リリース手順書**: 標準化されたリリースプロセスのドキュメント
4. **設計思想ドキュメント**: 本ドキュメントを含む、プロジェクト全体のアーキテクチャ説明

### 各プロジェクトでの活用

各CLIプロジェクト（diffx、diffai、lawkit）でClaude Codeを使用する際は、これらの共通リソースを参照・活用することで：

- 一貫性のある開発プロセスを維持
- リリース手順のミスを防止
- 新しいプロジェクトの立ち上げを効率化

これにより、各プロジェクトは機能開発に集中でき、インフラやプロセスの詳細は共通化された手順に委ねることができます。

## テストとビルドの共通化

### テストファイルの構成

各プロジェクトには、それぞれの言語形式に応じたテストファイルが配置されています：

- **Rust**: `tests/` ディレクトリ内の標準的なRustテスト
- **Python**: Python形式のテストファイル
- **JavaScript/npm**: JavaScript形式のテストファイル

これらは各プロジェクト固有の機能をテストしますが、実行方法は共通化されています。

### 共通シェルスクリプトによる実行

`.github` リポジトリ内のシェルスクリプトは、統一されたインターフェースで各プロジェクトのテストを実行します：

1. **クイックチェック用スクリプト**
   - プッシュのたびに実行される軽量なテスト
   - 基本的な動作確認とビルドチェック

2. **リリース用スクリプト**
   - タグのプッシュ時にのみ実行される完全なテストスイート
   - 全言語バインディングのビルドと検証
   - パッケージング前の最終確認

### GitHub Actionsワークフロー

ワークフローは最小限の記述に留め、実際の処理はシェルスクリプトに委譲しています：

```yaml
# ワークフローの例（概念的）
- name: Run tests
  run: ./.github/scripts/test-quick.sh  # または test-release.sh
```

### 実行環境の抽象化

シェルスクリプトは以下の両方の環境で動作するよう設計されています：

1. **GitHub Actions環境**: CI/CDパイプライン内での自動実行
2. **ローカル環境**: 開発者のマシンでの直接実行

環境の違いは条件分岐で吸収し、同じスクリプトが両方で動作します：

```bash
# 環境判定の例
if [ -n "$GITHUB_ACTIONS" ]; then
  # GitHub Actions固有の処理
else
  # ローカル実行時の処理
fi
```

### 共通処理の集約

複数のスクリプトから呼び出される共通処理は `common/` ディレクトリに配置し、コードの重複を避けています。これにより：

- メンテナンスが容易
- 一箇所の修正で全スクリプトに反映
- 新しいスクリプトの追加が簡単

## クロスプラットフォーム対応

### サポート対象プラットフォーム

各プロジェクトは以下の5つのプラットフォームをサポートします：

1. **macOS (Intel)**: x86_64-apple-darwin
2. **macOS (Apple Silicon)**: aarch64-apple-darwin
3. **Linux (x86_64)**: x86_64-unknown-linux-gnu
4. **Linux (ARM64)**: aarch64-unknown-linux-gnu
5. **Windows (x86_64)**: x86_64-pc-windows-msvc

※ Windows ARM版は現時点では未対応（市場シェアが小さいため）

### 成果物の種類

#### Rustバイナリ
- 5種類のプラットフォーム別バイナリを生成
- 各プラットフォームでネイティブに動作

#### Pythonパッケージ（pip）
- 5種類のプラットフォーム別wheel
- 各OSに最適化されたバイナリを含む

#### JavaScriptパッケージ（npm）
- 1種類のパッケージに全5プラットフォームのバイナリを同梱
- インストール時に適切なバイナリが選択される
- 全プラットフォームでの動作を保証するため、テストは5種類実施

### 動作保証プロセス

動作保証は以下の2段階で実施されます：

#### 1. パブリッシュ前の確認（プレリリーステスト）
- ローカル環境で実行可能な1種類のプラットフォームでテスト
- ビルド成果物が正しく生成されているか確認
- 基本的な機能が動作することを検証

#### 2. パブリッシュ後の確認（ポストリリーステスト）
- 公開されたパッケージを実際にダウンロード
- 各パッケージマネージャー（crates.io、PyPI、npm）から取得
- インストールと基本動作を確認
- 実際のユーザーと同じ手順で検証することで品質を保証

この2段階の検証により、リリースされたソフトウェアが確実に動作することを保証しています。

## ドキュメントとテストの連携

### 多言語ドキュメント

各プロジェクトのドキュメントは以下の3言語で提供されます：

- **日本語** (ja)
- **英語** (en)
- **中国語** (zh)

ドキュメントはREADMEおよびdocs/フォルダ内に配置され、各言語版で同じ内容を提供します。

### 使用例とテストケースの1対1対応

ドキュメント内に記載される使用例は、必ず対応するテストケースを持つというルールがあります。これにより：

1. **ドキュメントの正確性**: 使用例が実際に動作することを保証
2. **回帰テスト**: ドキュメントの例が将来のバージョンでも動作し続けることを確認
3. **メンテナンス性**: ドキュメントとテストを同期して更新

### テストファイルの構成

各言語実装（Rust、Python、JavaScript）にはそれぞれテストフォルダがあります：

```
プロジェクト名/
├── プロジェクト名-cli/
│   └── tests/
│       ├── basic/           # 基本機能のテスト
│       ├── advanced/        # 高度な機能のテスト
│       └── examples/        # ドキュメント使用例のテスト
├── プロジェクト名-python/
│   └── tests/
│       └── examples/        # ドキュメント使用例のテスト
└── プロジェクト名-npm/
    └── tests/
        └── examples/        # ドキュメント使用例のテスト
```

`examples/` サブフォルダには、ドキュメント内の使用例と1対1で対応するテストケースが配置されます。例えば：

- ドキュメント: 「ファイル比較の基本的な使い方」
- テストケース: `tests/examples/basic_file_comparison.rs`

この構造により、ドキュメントの信頼性を保ちながら、ユーザーに確実に動作する使用例を提供できます。

## 現状の課題と解決策

### 1. 多言語ドキュメントの同期問題

**現状の問題**:
- 日英中のドキュメント間で差分が発生している
- 英語版のみが更新され、他の言語版の更新が漏れることが多い
- Claude Codeは同一ディレクトリ内の多言語版ファイル（例：README.md、README_ja.md、README_zh.md）を一緒に更新することを忘れがち

**考えられる解決策**:
1. **絶対に漏れない仕組みの構築**
   - 単一ファイルの更新時に、自動的に多言語版の存在をチェックして警告
   - CI/CDで言語版間の差分を検出し、更新漏れを防ぐ
   - Claude Codeへの明示的な指示（CLAUDE.mdなど）で多言語更新を必須化

2. **定期的な翻訳の自動化**
   - 英語版をマスターとして、定期的に他言語版を自動翻訳で更新
   - 差分が発生した部分のみを翻訳し、人間によるレビューを挟む
   - 翻訳状態を管理するメタデータの導入

### 2. 共通コードへのプロジェクト名混入

**現状の問題**:
- `.github`内の共通コードに、特定のプロジェクト名（diffx、diffai、lawkitなど）が直接書かれることがある
- これは共通化の原則に反し、メンテナンス性を損なう

**解決のためのルール**:
1. **変数化の徹底**
   - プロジェクト名は必ず環境変数や設定ファイルから取得
   - 例：`PROJECT_NAME`、`CRATE_NAME`などの変数を使用

2. **レビュー時のチェックリスト**
   - 共通コードに特定のプロジェクト名が含まれていないことを確認
   - 正規表現による自動チェックの導入

3. **テンプレート化**
   ```bash
   # 悪い例（.github内で書いてはいけない）
   cargo test -p diffx-core
   
   # 良い例
   cargo test -p ${PROJECT_NAME}-core
   ```

### 3. プロジェクト間の不要な差分

**現状の問題**:
- 3つのプロジェクト（diffx、diffai、lawkit）間で、機能の違い以外の部分にも差分が発生している
- コードやフォルダ構成において、ツール名以外の差分があるべきではない部分に差分が存在
- 各リポジトリで独立してClaude Codeを使用しているため、同期的な更新ができていない
- 同じ目的の等価なコードなのに微妙な実装の違いが蓄積されている

**理想的な状態**:
- プロジェクト名を変数に置き換えれば、すべてのプロジェクトで完全に同一のコード
- 機能による必要な違いのみが存在し、それ以外は100%共通
- 新しいプロジェクトは既存プロジェクトの完全なコピーから始められる

**解決アプローチ**:
1. **定期的な同期作業**
   - 定期的に3プロジェクトのコードを比較し、不要な差分を検出
   - 差分を解消するための同期作業を実施
   - 理想的にはこれも自動化する

2. **テンプレートプロジェクトの作成**
   - 共通部分を抽出した「スケルトンプロジェクト」を作成
   - 新規プロジェクトはこのテンプレートから生成
   - 既存プロジェクトもテンプレートに合わせて調整

3. **Claude Code向けの明確な指示**
   - 各プロジェクトのCLAUDE.mdに「他プロジェクトとの同期」セクションを追加
   - 変更時は必ず他のプロジェクトも更新するよう指示
   - 定期的な差分チェックをタスクとして組み込む

4. **自動差分検出ツール**
   ```bash
   # プロジェクト間の差分を検出（プロジェクト名を正規化して比較）
   diff -r --exclude=".git" --exclude="target" \
     <(sed 's/diffx/PROJECT_NAME/g' ../diffx) \
     <(sed 's/diffai/PROJECT_NAME/g' ../diffai)
   ```

### 今後の改善方針

これらの課題を解決するため、以下のアプローチを検討しています：

1. **自動化の強化**: 人為的ミスを減らすため、可能な限り自動化する
2. **明確なガイドライン**: Claude Codeや開発者向けの明確な指示書を整備
3. **継続的な検証**: CI/CDパイプラインで問題を早期に発見する仕組みの構築
4. **完全な同期の実現**: 3プロジェクト間の不要な差分をゼロにし、理想的な形を実現

### 4. シェルスクリプトの複雑性とデグレード

**現状の問題**:
- シェルスクリプトの分岐が複雑化し、一つの改善が他の部分でデグレードを引き起こすことが多い
- リリース手順に応じて番号付きのスクリプト（例：1-build.sh、2-test.shなど）があり、別番号のスクリプトから共通処理を呼び出す際に問題が発生
- ワークフローでは確認できない項目と、ローカル実行では確認できない項目のどちらか一方でデグレードが発生
- ローカル/GitHub Actionsの判定、OSの判定が誤っていることが多い

**具体的な問題例**:
```bash
# ローカル/Actionsの判定が誤っている例
if [ "$GITHUB_ACTIONS" = "true" ]; then  # 大文字小文字の間違い
if [ -n "$CI" ]; then  # 環境変数の間違い

# OS判定が不正確な例
if [[ "$OSTYPE" == "darwin"* ]]; then  # macOSのarm64/x86_64の区別がない
if [ "$(uname)" = "Linux" ]; then  # WSLや特殊なLinux環境の考慮不足
```

**解決アプローチ**:
1. **環境判定の標準化**
   ```bash
   # common/env-detect.sh に環境判定を集約
   detect_environment() {
     if [ -n "$GITHUB_ACTIONS" ]; then
       echo "github-actions"
     elif [ -n "$CI" ]; then
       echo "ci-other"
     else
       echo "local"
     fi
   }
   
   detect_os() {
     local os="$(uname -s)"
     local arch="$(uname -m)"
     case "$os" in
       Darwin) echo "macos-$arch" ;;
       Linux) echo "linux-$arch" ;;
       MINGW*|MSYS*|CYGWIN*) echo "windows-$arch" ;;
       *) echo "unknown-$arch" ;;
     esac
   }
   ```

2. **テストマトリクスの作成**
   - 各スクリプトがどの環境でテストされるべきかを明確化
   - ローカルとGitHub Actionsの両方でテスト可能な部分を特定
   - テスト不可能な部分はモックやスタブを使用

3. **分岐の単純化**
   ```bash
   # 悪い例：複雑な分岐
   if [ "$ENV" = "local" ] && [ "$OS" = "macos" ]; then
     # 処理A
   elif [ "$ENV" = "ci" ] && [ "$OS" = "linux" ]; then
     # 処理B
   else
     # デフォルト処理
   fi
   
   # 良い例：分離された処理
   # 環境とOSを別々に処理
   setup_env_specific
   setup_os_specific
   run_common_process
   ```

4. **デグレード防止の仕組み**
   - 共通処理を変更した場合、すべての呼び出し元をテストするスクリプト
   - 各スクリプトの依存関係を明示的にドキュメント化
   - CI/CDですべての組み合わせをテスト

5. **エラーハンドリングの強化**
   ```bash
   # すべてのスクリプトの冒頭に追加
   set -euo pipefail  # エラー時に即座に終了
   
   # デバッグ情報の出力
   if [ "${DEBUG:-}" = "1" ]; then
     set -x  # コマンドを表示
     echo "Environment: $(detect_environment)"
     echo "OS: $(detect_os)"
   fi
   ```

### 5. ローカルテストとGitHub Actionsの結果の不一致

**現状の問題**:
- リリース前にローカルでクイックチェックと04、05、08番のリリーステストスクリプトを実行し、パスしたらタグをプッシュしている
- しかし、ローカルでパスしてもGitHub Actionsではエラーになることがあり、ローカルテストが安心感につながらない
- 同じはずのdiffaiでリリースに成功しても、diffxでは失敗することがある
- このような不一致により、リリースプロセスの信頼性が損なわれている

**考えられる原因**:
1. **環境の違い**
   - ローカルマシンのセットアップとGitHub Actionsランナーの環境の違い
   - インストールされているツールのバージョン差異
   - 環境変数や設定ファイルの有無

2. **タイミング依存の問題**
   - パッケージレジストリの同期タイミング
   - 依存関係の解決タイミング
   - キャッシュの有無

3. **権限の違い**
   - ローカルとGitHub Actionsでのファイルシステム権限の違い
   - シークレットやトークンへのアクセス方法の違い

**解決アプローチ**:
1. **環境の完全な同期**
   ```bash
   # ローカル環境とCI環境を可能な限り同一にする
   # Dockerコンテナを使用した統一環境の構築
   docker run --rm -v "$PWD:/work" \
     rust-cli-kiln-env \
     bash -c "cd /work && ./scripts/04-test.sh"
   ```

2. **詳細なログ出力**
   ```bash
   # すべてのスクリプトに詳細なログを追加
   log_environment() {
     echo "=== Environment Info ==="
     echo "Script: $0"
     echo "PWD: $PWD"
     echo "User: $(whoami)"
     echo "OS: $(detect_os)"
     echo "Env: $(detect_environment)"
     echo "Path: $PATH"
     echo "======================="
   }
   ```

3. **プロジェクト間の差異の検出**
   ```bash
   # diffaiで成功してdiffxで失敗する場合の差分を自動検出
   compare_project_environments() {
     local project1="$1"
     local project2="$2"
     
     # 環境変数の比較
     diff <(cd "../$project1" && env | sort) \
          <(cd "../$project2" && env | sort)
     
     # 依存関係の比較
     diff <(cd "../$project1" && cargo tree) \
          <(cd "../$project2" && cargo tree)
   }
   ```

4. **段階的な検証プロセス**
   - **レベル1**: 基本的な構文チェック（ローカルで高速実行）
   - **レベル2**: ビルドテスト（ローカルで実行可能）
   - **レベル3**: 統合テスト（Dockerで環境統一）
   - **レベル4**: リリーステスト（CI環境をシミュレート）

5. **失敗時の自動診断**
   ```bash
   # エラー発生時に自動的に診断情報を収集
   on_error() {
     echo "Error occurred in $0 at line $1"
     echo "Last command: $BASH_COMMAND"
     echo "Exit code: $?"
     
     # 環境情報を出力
     log_environment
     
     # よくある問題のチェック
     check_common_issues
   }
   trap 'on_error $LINENO' ERR
   ```

6. **ローカルでのCI環境再現**
   ```bash
   # GitHub Actionsの環境を完全に再現するツール
   # act (https://github.com/nektos/act) の使用
   act -j test --secret-file .env.local
   ```

これらの対策により、ローカルテストの信頼性を向上させ、プロジェクト間の不整合を減らすことを目指します。

### 6. プロジェクト名取得の不統一

**現状の問題**:
- プロジェクト名の取得方法が統一されていない
- フォルダ名がプロジェクト名であるというルールがあるが、一貫性のある実装がされていない
- GitHub Actionsでフォルダ名を取得できない場合があるかもしれないという不確実性

**理想的な解決策**:
```bash
# common/project-name.sh
# プロジェクト名を取得する統一関数
get_project_name() {
  # 優先順位1: 環境変数から
  if [ -n "${PROJECT_NAME:-}" ]; then
    echo "$PROJECT_NAME"
    return
  fi
  
  # 優先順位2: Gitリポジトリ名から
  local repo_name="$(git config --get remote.origin.url | sed 's/.*\///' | sed 's/\.git$//')"
  if [ -n "$repo_name" ]; then
    echo "$repo_name"
    return
  fi
  
  # 優先順位3: 現在のディレクトリ名から
  basename "$(pwd)"
}

# GitHub Actionsでの使用例
# .github/workflows/内では
env:
  PROJECT_NAME: ${{ github.event.repository.name }}
```

### 7. 複数プロジェクトの一括管理

**現状の制約**:
- 4プロジェクト（.github、diffx、diffai、lawkit）のコードやテスト、Git操作を1つのVSCodeで管理したい
- Claude Codeは通常、現在のプロジェクトディレクトリ外の操作に制限がある
- しかし、この制限を回避する方法が存在する

**一括管理のアプローチ**:

1. **シンボリックリンクによる統合**
   ```bash
   # .githubプロジェクト内に他プロジェクトへのシンボリックリンクを作成
   .github/
   ├── projects/
   │   ├── diffx -> ../../diffx
   │   ├── diffai -> ../../diffai
   │   └── lawkit -> ../../lawkit
   ```

2. **絶対パスを使用したアクセス**
   ```bash
   # 現在のディレクトリから相対パスで他プロジェクトにアクセス
   # .githubから実行する場合
   cd ../diffx && git status
   cd ../diffai && npm test
   cd ../lawkit && cargo build
   ```

3. **モノリポジトリ構成の検討**
   ```
   rust-cli-kiln/              # モノリポジトリルート
   ├── .github/               # 共通コード
   ├── projects/
   │   ├── diffx/
   │   ├── diffai/
   │   └── lawkit/
   └── scripts/               # 一括管理スクリプト
   ```

4. **一括操作スクリプト**
   ```bash
   # scripts/sync-all.sh
   # すべてのプロジェクトに対して同じ操作を実行
   for project in diffx diffai lawkit; do
     echo "Processing $project..."
     cd "../$project" || continue
     
     # 共通の更新を適用
     git pull origin main
     
     # 依存関係を更新
     cargo update
     
     # テストを実行
     cargo test
     
     cd - > /dev/null
   done
   ```

5. **VSCodeワークスペースの活用**
   ```json
   // rust-cli-kiln.code-workspace
   {
     "folders": [
       { "path": ".github" },
       { "path": "../diffx" },
       { "path": "../diffai" },
       { "path": "../lawkit" }
     ],
     "settings": {
       "terminal.integrated.cwd": "${workspaceFolder:/.github}"
     }
   }
   ```

### コンテキスト保持のための提案

1. **CLAUDE.mdの活用**
   - 各プロジェクトのCLAUDE.mdに、他プロジェクトへの参照方法を記載
   - 一括操作時の注意点を明記

2. **共通タスクの定義**
   ```bash
   # .github/tasks/sync-documentation.sh
   # すべてのプロジェクトのドキュメントを同期
   
   # .github/tasks/update-dependencies.sh
   # すべてのプロジェクトの依存関係を更新
   ```

3. **プロジェクト間の差分確認ツール**
   ```bash
   # .github/tools/diff-projects.sh
   # プロジェクト間の不要な差分を検出
   ```

これらの方法を組み合わせることで、単一のClaude Codeセッションから複数プロジェクトを効率的に管理できるようになります。

### 8. プラットフォーム固有の問題

**現状の問題**:
- macOSでのみ`sed`コマンドの挙動が異なるなど、プラットフォーム固有の違いが存在
- これらは実際にエラーに遭遇するまで気づけない「隠れた地雷」となっている
- 一度一つのプロジェクトで成功しても、別のプロジェクトや別の環境で失敗することがある

**よくあるプラットフォーム固有の問題**:
1. **sedコマンドの違い**
   ```bash
   # macOS (BSD sed) では -i オプションに引数が必要
   sed -i '' 's/old/new/g' file.txt
   
   # Linux (GNU sed) では -i オプションに引数不要
   sed -i 's/old/new/g' file.txt
   
   # 統一的な解決策: ポータブルな書き方
   # 方法1: 一時ファイルを使用
   sed 's/old/new/g' file.txt > file.txt.tmp && mv file.txt.tmp file.txt
   
   # 方法2: プラットフォーム判定
   if [[ "$OSTYPE" == "darwin"* ]]; then
     sed -i '' 's/old/new/g' file.txt
   else
     sed -i 's/old/new/g' file.txt
   fi
   ```

2. **その他のコマンドの違い**
   ```bash
   # date コマンドのフォーマット
   # macOS
   date -j -f "%Y-%m-%d" "2024-01-01" +%s
   # Linux
   date -d "2024-01-01" +%s
   
   # readlink コマンド
   # macOS: greadlink (coreutils必要)
   # Linux: readlink
   ```

**解決アプローチ**:

1. **ポータブルスクリプトライブラリの構築**
   ```bash
   # common/portable.sh
   # プラットフォーム差異を吸収する関数群
   
   portable_sed_inplace() {
     local pattern="$1"
     local file="$2"
     
     if [[ "$OSTYPE" == "darwin"* ]]; then
       sed -i '' "$pattern" "$file"
     else
       sed -i "$pattern" "$file"
     fi
   }
   
   portable_date() {
     # 統一的なdate処理
   }
   ```

2. **継続的な問題収集と文書化**
   ```markdown
   # .github/docs/platform-quirks.md
   # プラットフォーム固有の問題と解決策のリスト
   
   ## macOS固有
   - sed -i オプション
   - date コマンドフォーマット
   - ...
   
   ## Linux固有
   - ...
   
   ## Windows (Git Bash)固有
   - ...
   ```

3. **プラットフォーム横断テスト**
   ```yaml
   # .github/workflows/cross-platform-test.yml
   strategy:
     matrix:
       os: [ubuntu-latest, macos-latest, windows-latest]
   ```

### 理想的なリリースプロセスの実現

**目標**: 一度一つのプロジェクトで成功したら、そのまま他のプロジェクトでも確実に成功するリリーススクリプト・ワークフローの構築

1. **完全な再現性の確保**
   - すべての環境差異を吸収するポータブルなスクリプト
   - プラットフォーム固有の処理は必ず抽象化
   - エラー発生時の詳細なログ出力

2. **段階的な検証**
   ```bash
   # リリース前の検証フロー
   1. ローカルでのポータビリティチェック
   2. Dockerでの統一環境テスト
   3. CI環境でのドライラン
   4. 本番リリース
   ```

3. **成功パターンの蓄積**
   ```bash
   # .github/release-patterns/
   # 成功したリリースのログとパラメータを保存
   # 新しいリリース時に参照・比較
   ```

4. **リリースチェックリスト自動化**
   ```bash
   # すべての前提条件を自動チェック
   check_release_prerequisites() {
     echo "Checking release prerequisites..."
     
     # ツールのバージョン確認
     check_tool_versions
     
     # 環境変数の確認
     check_environment_variables
     
     # プラットフォーム固有の確認
     check_platform_specific
     
     # 依存関係の確認
     check_dependencies
   }
   ```

これらの対策により、「一度成功したら必ず成功する」信頼性の高いリリースプロセスを実現し、プラットフォーム固有の問題による予期せぬエラーを防ぐことができます。