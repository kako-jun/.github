# 包括的マトリクス管理システム - 抜け漏れ防止用多次元管理表

## 目的

3プロジェクト（lawkit, diffai, diffx）の包括的なテスト網羅率100%達成のため、作業の抜け漏れを防止する多次元マトリクス管理システムを構築します。

## 基本原則

### 1. **TDD（テスト駆動開発）の厳格な遵守**
- **仕様書を先に更新**：実装前に必ず仕様を明確化
- **仕様に対するテストケースを追加**：テストを先に作成
- **実装はその後**：テストに合格する実装を行う
- **実装中に勝手に仕様を変更してはいけない**：仕様変更は別途仕様書更新から開始

### 2. **慎重性の重視**
- 速度よりも精度を重視
- ドキュメントから正確な情報を抽出
- リリース状況の事実確認を徹底

### 3. **実装状況の正確把握**
- 各パッケージの実際の機能対応を調査
- pip/npmパッケージの実装内容を詳細確認
- テスト網羅率の現実的な評価

### 4. **マトリクス自動更新の原則**
- **見える化重視**: 人間は全体把握→詳細埋め込みの順序でないと理解困難
- **仕様変更時の自動判断**: 機能追加・変更時は対応マトリクス更新が必須
- **手動指示排除**: ユーザーがいちいち指示しなくても自動的に判断・実行

#### マトリクス更新トリガー
1. **CLI引数・オプション追加/変更時**
   - → 1番「テスト網羅状況マトリクス」に縦軸追加
   - → 全実装形態（Rust CLI/Core, pip, npm）で🔍セル追加
   
2. **テストファイル追加/移動時**
   - → 2番「テストディレクトリ活用状況」の件数再集計
   - → 全プロジェクト×全実装形態で正確な件数更新
   
3. **ドキュメント追加/変更時**
   - → 4番「ドキュメント対応テストコード」に縦軸追加・再集計
   - → 5番「ドキュメント翻訳・整合性」に縦軸追加・再集計
   - → 使用例数とテストケース数の整合性確認

#### 自動判断基準
- **仕様変更検出**: Cargo.toml、CLI定義、ドキュメントの変更を監視
- **完全性確保**: 新機能は全マトリクスで🔍状態から開始
- **整合性維持**: 4番と5番のドキュメントリストは常に同一
- **抜け漏れ防止**: 変更時は関連する全マトリクスを同時更新

---

## 📊 1. テスト網羅状況マトリクス（引数・オプション別）

### diffx テストパス状況（実装形態別）

| 引数・オプション | Rust CLI | Rust Core | pip package | npm package | テスト網羅率 |
|------------------|----------|-----------|-------------|-------------|-------------|
| **基本引数** |  |  |  |  |  |
| `<INPUT1>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `<INPUT2>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| **基本オプション** |  |  |  |  |  |
| `--help, -h` | 🔍 | N/A | N/A | N/A | 0% |
| `--version, -V` | 🔍 | N/A | 🔍 | 🔍 | 0% |
| `--format <FORMAT>, -f` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--output <OUTPUT>, -o` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--recursive, -r` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--quiet, -q` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--brief` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--verbose, -v` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--no-color` | 🔍 | N/A | N/A | N/A | 0% |
| **比較オプション** |  |  |  |  |  |
| `--path <PATH>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--ignore-keys-regex <REGEX>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--epsilon <EPSILON>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--array-id-key <ARRAY_ID_KEY>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--context <CONTEXT>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--ignore-whitespace` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--ignore-case` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |

### diffai テストパス状況（実装形態別）

| 引数・オプション | Rust CLI | Rust Core | pip package | npm package | テスト網羅率 |
|------------------|----------|-----------|-------------|-------------|-------------|
| **基本引数** |  |  |  |  |  |
| `<INPUT1>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `<INPUT2>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| **基本オプション** |  |  |  |  |  |
| `--help, -h` | 🔍 | N/A | N/A | N/A | 0% |
| `--version, -V` | 🔍 | N/A | 🔍 | 🔍 | 0% |
| `--format <FORMAT>, -f` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--output <OUTPUT>, -o` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--recursive, -r` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--verbose, -v` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--no-color` | 🔍 | N/A | N/A | N/A | 0% |
| **高度オプション** |  |  |  |  |  |
| `--path <PATH>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--ignore-keys-regex <REGEX>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--epsilon <EPSILON>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--array-id-key <ARRAY_ID_KEY>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |

### lawkit テストパス状況（実装形態別）

| 引数・オプション | Rust CLI | Rust Core | pip package | npm package | テスト網羅率 |
|------------------|----------|-----------|-------------|-------------|-------------|
| **基本引数** |  |  |  |  |  |
| `[input]` (analyze) | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| **基本オプション** |  |  |  |  |  |
| `--help, -h` | 🔍 | N/A | N/A | N/A | 0% |
| `--version, -V` | 🔍 | N/A | 🔍 | 🔍 | 0% |
| **サブコマンド** |  |  |  |  |  |
| `benf` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `pareto` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `zipf` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `normal` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `poisson` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `analyze` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `validate` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `diagnose` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `generate` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `list` | 🔍 | N/A | 🔍 | 🔍 | 0% |
| `selftest` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| **analyze系オプション** |  |  |  |  |  |
| `--format <FORMAT>, -f` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--quiet, -q` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--verbose, -v` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--filter <RANGE>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--min-count <NUMBER>, -c` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--no-color` | 🔍 | N/A | N/A | N/A | 0% |
| `--laws <LAWS>, -l` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--focus <FOCUS>, -F` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--threshold <THRESHOLD>, -t` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--recommend, -r` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--report <TYPE>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--consistency-check` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--cross-validation` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--confidence-level <LEVEL>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--purpose <PURPOSE>, -p` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |


**現実**: Unit/Integrationテストが全プロジェクトで未実装。テストケースパス状況で実装完了度を管理。

**注記**: 
- ✅ = テストパス済み（実装完了・動作確認済み）
- 🔍 = テスト未実施（実装状況不明・要調査）
- ❌ = テスト失敗または未実装
- N/A = 該当実装形態では対象外

**テストディレクトリ活用状況記号**:
- ✅ N件 = テストケース実装済み・動作確認済み
- 🔴 0件 = **緊急対応必要** - テストケース未実装

---

## 📁 2. テストディレクトリ活用状況

### diffx プロジェクト

| テストディレクトリ | Rust CLI | pip package | npm package | 目的 |
|-------------------|----------|-------------|-------------|------|
| **tests/basic** | ✅ 4件 | 🔍 ?件 | 🔍 ?件 | 基本機能テスト |
| **tests/cli** | ✅ 7件 | 🔍 ?件 | 🔍 ?件 | CLI動作テスト |
| **tests/core** | ✅ 5件 | N/A | N/A | Coreライブラリテスト |
| **tests/docs_examples** | ✅ 4件 | 🔍 ?件 | 🔍 ?件 | ドキュメント例示テスト |
| **tests/errors** | ✅ 3件 | 🔍 ?件 | 🔍 ?件 | エラーハンドリングテスト |
| **tests/features** | ✅ 6件 | 🔍 ?件 | 🔍 ?件 | 個別機能テスト |
| **tests/fixtures** | ✅ 0件 | N/A | N/A | テストデータ管理 |
| **tests/formats** | ✅ 7件 | 🔍 ?件 | 🔍 ?件 | 出力形式テスト |
| **tests/integration** | ✅ 2件 | 🔍 ?件 | 🔍 ?件 | 統合テスト専用 |
| **tests/output** | ✅ 0件 | N/A | N/A | 出力検証テスト |
| **tests/unit** | ✅ 2件 | 🔍 ?件 | 🔍 ?件 | 単体テスト専用 |

### diffai プロジェクト

| テストディレクトリ | Rust CLI | pip package | npm package | 目的 |
|-------------------|----------|-------------|-------------|------|
| **tests/basic** | ✅ 4件 | 🔍 ?件 | 🔍 ?件 | 基本機能テスト |
| **tests/cli** | ✅ 5件 | 🔍 ?件 | 🔍 ?件 | CLI動作テスト |
| **tests/core** | ✅ 2件 | N/A | N/A | Coreライブラリテスト |
| **tests/docs_examples** | ✅ 4件 | 🔍 ?件 | 🔍 ?件 | ドキュメント例示テスト |
| **tests/errors** | ✅ 2件 | 🔍 ?件 | 🔍 ?件 | エラーハンドリングテスト |
| **tests/features** | ✅ 12件 | 🔍 ?件 | 🔍 ?件 | 個別機能テスト |
| **tests/fixtures** | ✅ 0件 | N/A | N/A | テストデータ管理 |
| **tests/formats** | ✅ 6件 | 🔍 ?件 | 🔍 ?件 | 出力形式テスト |
| **tests/integration** | ✅ 2件 | 🔍 ?件 | 🔍 ?件 | 統合テスト専用 |
| **tests/output** | ✅ 0件 | N/A | N/A | 出力検証テスト |
| **tests/unit** | ✅ 2件 | 🔍 ?件 | 🔍 ?件 | 単体テスト専用 |
| **総計** | ✅ 39件 | 🔍 ?件 | 🔍 ?件 | 全テストファイル数 |

### lawkit プロジェクト

| テストディレクトリ | Rust CLI | pip package | npm package | 目的 |
|-------------------|----------|-------------|-------------|------|
| **tests/basic** | ✅ 6件 | 🔍 ?件 | 🔍 ?件 | 基本機能テスト |
| **tests/cli** | ✅ 5件 | 🔍 ?件 | 🔍 ?件 | CLI動作テスト |
| **tests/core** | ✅ 6件 | N/A | N/A | Coreライブラリテスト |
| **tests/docs_examples** | ✅ 1件 | 🔍 ?件 | 🔍 ?件 | ドキュメント例示テスト |
| **tests/errors** | ✅ 3件 | 🔍 ?件 | 🔍 ?件 | エラーハンドリングテスト |
| **tests/features** | ✅ 10件 | 🔍 ?件 | 🔍 ?件 | 個別機能テスト |
| **tests/fixtures** | ✅ 1件 | N/A | N/A | テストデータ管理 |
| **tests/formats** | ✅ 4件 | 🔍 ?件 | 🔍 ?件 | 出力形式テスト |
| **tests/integration** | ✅ 0件 | 🔍 ?件 | 🔍 ?件 | 統合テスト専用 |
| **tests/output** | ✅ 0件 | N/A | N/A | 出力検証テスト |
| **tests/unit** | ✅ 2件 | 🔍 ?件 | 🔍 ?件 | 単体テスト専用 |
| **総計** | ✅ 38件 | 🔍 ?件 | 🔍 ?件 | 全テストファイル数 |


### 🔴 緊急対応必要（テストケース0件ディレクトリ）

#### 全プロジェクト共通
- **tests/unit**: 🔍 3/9 未確認（Rust CLIで要調査）+ 🔴 6/9 未実装（pip/npm）
- **tests/integration**: 🔍 3/9 未確認（Rust CLIで要調査）+ 🔴 6/9 未実装（pip/npm）
- **tests/core**: 🔍 3/3 未確認（Rust CLI専用、pip/npmでN/A）
- **tests/fixtures**: 🔍 3/3 未確認（Rust CLI専用、pip/npmでN/A）
- **tests/output**: 🔍 3/3 未確認（Rust CLI専用、pip/npmでN/A）

#### プロジェクト別0件ディレクトリ
**lawkit**:
- **pip**: tests/cli, tests/docs_examples, tests/features, tests/formats, tests/errors, tests/integration, tests/unit（7ディレクトリ）

**diffai**:
- **pip**: 全9ディレクトリ（tests/basic除く8ディレクトリ）
- **npm**: tests/docs_examples（1ディレクトリ）

**diffx**:
- **pip**: 全9ディレクトリ（tests/basic除く8ディレクトリ）
- **npm**: tests/docs_examples（1ディレクトリ）

### 📊 活用状況サマリ
- **🔴 0件ディレクトリ**: 合計18個（緊急対応必要）
- **🔍 未確認ディレクトリ**: 合計15個（要調査）
- **✅ 実装済み**: 合計24個（継続保守）
- **実装率**: 42%（目標100%、未確認含むと68%）

---

## 🔧 3. テストスクリプト実行状況マトリクス

### diffx プロジェクト

| テストスクリプト | ローカル実行 | GitHub Actions | 分岐パターン確認 |
|-----------------|-------------|----------------|------------------|
| **04-test-package.sh** | 🔍 未確認 | 🔍 未確認 | 複数呼び出し方式対応要確認 |
| **05-test-coverage.sh** | 🔍 未確認 | 🔍 未確認 | カバレッジ測定分岐要確認 |
| **08-test-release.sh** | 🔍 未確認 | 🔍 未確認 | リリース前テスト分岐要確認 |

### diffai プロジェクト

| テストスクリプト | ローカル実行 | GitHub Actions | 分岐パターン確認 |
|-----------------|-------------|----------------|------------------|
| **04-test-package.sh** | 🔍 未確認 | 🔍 未確認 | 複数呼び出し方式対応要確認 |
| **05-test-coverage.sh** | 🔍 未確認 | 🔍 未確認 | カバレッジ測定分岐要確認 |
| **08-test-release.sh** | 🔍 未確認 | 🔍 未確認 | リリース前テスト分岐要確認 |

### lawkit プロジェクト

| テストスクリプト | ローカル実行 | GitHub Actions | 分岐パターン確認 |
|-----------------|-------------|----------------|------------------|
| **04-test-package.sh** | 🔍 未確認 | 🔍 未確認 | 複数呼び出し方式対応要確認 |
| **05-test-coverage.sh** | 🔍 未確認 | 🔍 未確認 | カバレッジ測定分岐要確認 |
| **08-test-release.sh** | 🔍 未確認 | 🔍 未確認 | リリース前テスト分岐要確認 |


### 🔴 緊急対応必要（スクリプト実行状況）

#### 全プロジェクト共通課題
- **実行確認**: 18/18 未確認（3プロジェクト × 3スクリプト × 2環境）
- **分岐パターン**: 複数の呼び出し方式でエラー無し終了の確認が必要
- **環境依存**: ローカル環境とGitHub Actions環境での動作差異確認

#### 優先対応順序
1. **ローカル実行確認**: 開発環境での基本動作確認
2. **Actions実行確認**: CI/CD環境での動作確認  
3. **分岐パターン網羅**: 全呼び出し方式でのエラーハンドリング確認

**注記**: 
- ✅ = 実行成功・エラー無し終了確認済み
- 🔍 = 実行未確認・要検証
- ❌ = 実行失敗・エラー発生

---

## 📚 4. ドキュメント対応テストコードマトリクス

### diffx プロジェクト

| ドキュメントファイル | 使用例数 | Rust CLI | pip package | npm package | 一致率 |
|---------------------|----------|----------|-------------|-------------|--------|
| **README.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/index.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/guides/integrations.md** | 🔍 ?例 | 🔍 tests/integration/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/guides/performance.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/guides/performance_benchmarks.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/reference/api-reference.md** | 🔍 ?例 | 🔍 tests/integration/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/reference/cli-reference.md** | 🔍 ?例 | 🔍 tests/cli/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/reference/comparison.md** | 🔍 ?例 | 🔍 tests/features/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/reference/diffx-format.md** | 🔍 ?例 | 🔍 tests/formats/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/examples.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/faq.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/getting-started.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/installation.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |

### diffai プロジェクト

| ドキュメントファイル | 使用例数 | Rust CLI | pip package | npm package | 一致率 |
|---------------------|----------|----------|-------------|-------------|--------|
| **README.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/index.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/architecture/design-principles.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/architecture/implementation.md** | 🔍 ?例 | 🔍 tests/integration/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/reference/cli-reference.md** | 🔍 ?例 | 🔍 tests/cli/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/reference/formats.md** | 🔍 ?例 | 🔍 tests/formats/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/reference/ml-analysis.md** | 🔍 ?例 | 🔍 tests/features/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/reference/ml-recommendations.md** | 🔍 ?例 | 🔍 tests/features/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/reference/output-formats.md** | 🔍 ?例 | 🔍 tests/formats/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/basic-usage.md** | 🔍 ?例 | 🔍 tests/basic/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/installation.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/ml-model-comparison.md** | 🔍 ?例 | 🔍 tests/features/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/ml-workflows.md** | 🔍 ?例 | 🔍 tests/features/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/scientific-data.md** | 🔍 ?例 | 🔍 tests/basic/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/verbose-output.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |

### lawkit プロジェクト

| ドキュメントファイル | 使用例数 | Rust CLI | pip package | npm package | 一致率 |
|---------------------|----------|----------|-------------|-------------|--------|
| **README.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/index.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/guides/advanced-analysis.md** | 🔍 ?例 | 🔍 tests/features/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/guides/architecture.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/guides/integrations.md** | 🔍 ?例 | 🔍 tests/integration/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/guides/performance.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/reference/cli-reference.md** | 🔍 ?例 | 🔍 tests/cli/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/configuration.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/examples.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/faq.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/getting-started.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/installation.md** | 🔍 ?例 | 🔍 tests/docs_examples/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |
| **docs/user-guide/usage.md** | 🔍 ?例 | 🔍 tests/basic/?件 | 🔍 ?件 | 🔍 ?件 | 要調査 |


### 🔴 緊急対応必要（ドキュメント使用例とテストケース不一致）

#### 全プロジェクト共通課題
- **使用例数調査**: 全ドキュメントの使用例数が未調査（41ファイル：lawkit13+diffai15+diffx13）
- **テストケース不足**: pip packages（41/41 未作成）, npm packages（38/41 未作成）
- **一致率確認**: ドキュメント使用例数 vs テストケース数の整合性未確認

#### 一致率管理の重要性
- **✅ 100%**: ドキュメント使用例数 = テストケース数（理想状態）
- **⚠️ 部分一致**: テストケース数 < 使用例数（テスト不足）
- **❌ 不一致**: テストケース数 > 使用例数（過剰テストまたは使用例不足）

#### 優先対応順序
1. **ドキュメント使用例数カウント**: 全41ファイルの例示コード数調査
2. **一致率算出**: 使用例数とテストケース数の比較
3. **不一致解消**: テストケース追加またはドキュメント例示追加

**注記**: 
- ✅ N件 = テストケース数確定・動作確認済み
- 🔍 ?例/?件 = 使用例数またはテストケース数要調査
- 🔴 0件 = テストケース未作成
- 一致率 = テストケース数/使用例数 × 100%

---

## 🌐 5. ドキュメント翻訳・整合性マトリクス

### diffx プロジェクト

| ドキュメントファイル (英語版) | 古い仕様記述チェック | 日本語翻訳 | 中国語翻訳 | 構造整合性 |
|-------------------------------|---------------------|------------|------------|------------|
| **README.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/index.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/guides/integrations.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/guides/performance.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/guides/performance_benchmarks.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/reference/api-reference.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/reference/cli-reference.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/reference/comparison.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/reference/diffx-format.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/examples.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/faq.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/getting-started.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/installation.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |

### diffai プロジェクト

| ドキュメントファイル (英語版) | 古い仕様記述チェック | 日本語翻訳 | 中国語翻訳 | 構造整合性 |
|-------------------------------|---------------------|------------|------------|------------|
| **README.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/index.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/architecture/design-principles.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/architecture/implementation.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/reference/cli-reference.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/reference/formats.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/reference/ml-analysis.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/reference/ml-recommendations.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/reference/output-formats.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/basic-usage.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/getting-started.md** | ❌ 未作成 | ❌ 未作成 | ❌ 未作成 | ❌ ファイル不在 |
| **docs/user-guide/installation.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/ml-model-comparison.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/ml-workflows.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/scientific-data.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/verbose-output.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |

### lawkit プロジェクト

| ドキュメントファイル (英語版) | 古い仕様記述チェック | 日本語翻訳 | 中国語翻訳 | 構造整合性 |
|-------------------------------|---------------------|------------|------------|------------|
| **README.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/index.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/guides/advanced-analysis.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/guides/architecture.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/guides/integrations.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/guides/performance.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/reference/cli-reference.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/configuration.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/examples.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/faq.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/getting-started.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/installation.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |
| **docs/user-guide/usage.md** | 🔍 未確認 | 🔍 翻訳確認要 | 🔍 翻訳確認要 | 🔍 構造未確認 |


### 🔴 緊急対応必要（ドキュメント翻訳・整合性）

#### 全プロジェクト共通課題
- **翻訳状況未確認**: 日本語・中国語版ファイル存在確認が必要（41ファイル：lawkit13+diffai15+diffx13）
- **構造整合性未確認**: 見出し数・コードブロック数・CLIオプション数の一致確認が必要
- **古い仕様記述**: check-docs-consistency.sh による自動チェック未実行（39ファイル未確認）

#### check-docs-consistency.sh 活用項目
1. **ファイル存在チェック**: `_ja.md`, `_zh.md` ファイルの存在確認
2. **基本構造チェック**: 見出し数の3言語一致確認
3. **コードブロック数チェック**: 使用例の3言語一致確認
4. **CLIオプション整合性**: cli-reference.md のオプション数一致確認
5. **キーワード整合性**: プロジェクト名、JSON、YAML等の一致確認

#### 優先対応順序（左から右の作業フロー）
1. **古い仕様記述チェック**: 英語版の最新性確認・古い記述の修正
2. **翻訳作業**: 最新化された英語版を基準に日本語・中国語翻訳実施
3. **構造整合性確認**: check-docs-consistency.sh実行による3言語一致確認

**注記**: 
- ✅ = 翻訳完了・整合性確認済み
- 🔍 = 確認が必要・check-docs-consistency.sh実行待ち
- ❌ = 翻訳未完了・不整合発見
- ⚠️ = 軽微な不整合・要注意

---

**注記**: テスト網羅状況が実装状況を兼ねるため、このマトリクスで効率的に管理。

この統合マトリクス管理により、重複を排除し効率的な100%網羅率達成を目指します。