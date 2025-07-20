# 包括的マトリクス管理システム - TDD順序準拠版

## 目的

3プロジェクト（lawkit, diffai, diffx）の**実測ベース**テストパス率100%達成のため、**TDDの正しい順序に沿った**多次元マトリクス管理システム。

**TDD順序**: 仕様確定 → テスト作成 → 実装・検証

## 基本原則

### マトリクス更新の絶対原則
- **✅の条件**: 実際のテスト実行で成功した場合のみ
- **❌の条件**: 実際のテスト実行で失敗した場合のみ  
- **🔍の条件**: テスト未実行・実装状況不明の場合のみ
- **実測値のみ反映**: 推測・仮定による更新禁止

---

## 🌐 1. ドキュメント翻訳・整合性マトリクス（仕様確定段階）

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

---

## 📚 2. ドキュメント対応テストコードマトリクス（テスト仕様段階）

### diffx プロジェクト

| ドキュメントファイル | 使用例数 | Rust CLI | pip package | npm package | 一致率 |
|---------------------|----------|----------|-------------|-------------|--------|
| **README.md** | 🔍 ?例 | 🔍 tests/docs_examples/4件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/index.md** | 🔍 ?例 | 🔍 tests/docs_examples/4件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/guides/integrations.md** | 🔍 ?例 | 🔍 tests/integration/2件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/guides/performance.md** | 🔍 ?例 | 🔍 tests/docs_examples/4件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/guides/performance_benchmarks.md** | 🔍 ?例 | 🔍 tests/docs_examples/4件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/reference/api-reference.md** | 🔍 ?例 | 🔍 tests/integration/2件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/reference/cli-reference.md** | 🔍 ?例 | 🔍 tests/cli/54件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/reference/comparison.md** | 🔍 ?例 | 🔍 tests/features/6件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/reference/diffx-format.md** | 🔍 ?例 | 🔍 tests/formats/7件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/user-guide/examples.md** | 🔍 ?例 | 🔍 tests/docs_examples/4件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/user-guide/faq.md** | 🔍 ?例 | 🔍 tests/docs_examples/4件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/user-guide/getting-started.md** | 🔍 ?例 | 🔍 tests/docs_examples/4件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/user-guide/installation.md** | 🔍 ?例 | 🔍 tests/docs_examples/4件 | 🔴 0件 | 🔴 0件 | 要調査 |

### diffai プロジェクト

| ドキュメントファイル | 使用例数 | Rust CLI | pip package | npm package | 一致率 |
|---------------------|----------|----------|-------------|-------------|--------|
| **README.md** | 🔍 ?例 | 🔍 tests/docs_examples/4件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/index.md** | 🔍 ?例 | 🔍 tests/docs_examples/4件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/architecture/design-principles.md** | 🔍 ?例 | 🔍 tests/docs_examples/4件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/architecture/implementation.md** | 🔍 ?例 | 🔍 tests/integration/2件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/reference/cli-reference.md** | 🔍 ?例 | 🔍 tests/cli/5件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/reference/formats.md** | 🔍 ?例 | 🔍 tests/formats/6件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/reference/ml-analysis.md** | 🔍 ?例 | 🔍 tests/features/12件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/reference/ml-recommendations.md** | 🔍 ?例 | 🔍 tests/features/12件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/reference/output-formats.md** | 🔍 ?例 | 🔍 tests/formats/6件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/user-guide/basic-usage.md** | 🔍 ?例 | 🔍 tests/basic/4件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/user-guide/installation.md** | 🔍 ?例 | 🔍 tests/docs_examples/4件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/user-guide/ml-model-comparison.md** | 🔍 ?例 | 🔍 tests/features/12件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/user-guide/ml-workflows.md** | 🔍 ?例 | 🔍 tests/features/12件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/user-guide/scientific-data.md** | 🔍 ?例 | 🔍 tests/basic/4件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/user-guide/verbose-output.md** | 🔍 ?例 | 🔍 tests/docs_examples/4件 | 🔴 0件 | 🔴 0件 | 要調査 |

### lawkit プロジェクト

| ドキュメントファイル | 使用例数 | Rust CLI | pip package | npm package | 一致率 |
|---------------------|----------|----------|-------------|-------------|--------|
| **README.md** | 🔍 ?例 | 🔍 tests/docs_examples/1件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/index.md** | 🔍 ?例 | 🔍 tests/docs_examples/1件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/guides/advanced-analysis.md** | 🔍 ?例 | 🔍 tests/features/10件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/guides/architecture.md** | 🔍 ?例 | 🔍 tests/docs_examples/1件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/guides/integrations.md** | 🔍 ?例 | 🔍 tests/integration/0件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/guides/performance.md** | 🔍 ?例 | 🔍 tests/docs_examples/1件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/reference/cli-reference.md** | 🔍 ?例 | 🔍 tests/cli/5件 | 🔴 0件 | ✅ 1件 | 要調査 |
| **docs/user-guide/configuration.md** | 🔍 ?例 | 🔍 tests/docs_examples/1件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/user-guide/examples.md** | 🔍 ?例 | 🔍 tests/docs_examples/1件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/user-guide/faq.md** | 🔍 ?例 | 🔍 tests/docs_examples/1件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/user-guide/getting-started.md** | 🔍 ?例 | 🔍 tests/docs_examples/1件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/user-guide/installation.md** | 🔍 ?例 | 🔍 tests/docs_examples/1件 | 🔴 0件 | 🔴 0件 | 要調査 |
| **docs/user-guide/usage.md** | 🔍 ?例 | 🔍 tests/basic/6件 | 🔴 0件 | ✅ 1件 | 要調査 |

---

## 📁 3. テストディレクトリ活用状況（テスト実装段階）

### diffx プロジェクト

| テストディレクトリ | Rust CLI | pip package | npm package | 目的 |
|-------------------|----------|-------------|-------------|------|
| **tests/basic** | ✅ 9件 | 🔴 0件 | ✅ 1件 | 基本機能テスト |
| **tests/cli** | ✅ 54件 | 🔴 0件 | ✅ 1件 | CLI動作テスト |
| **tests/core** | ✅ 48件 | N/A | ✅ 1件 | Coreライブラリ・単体テスト |
| **tests/docs_examples** | ✅ 8件 | 🔴 0件 | 🔴 0件 | ドキュメント例示テスト |
| **tests/errors** | ✅ 7件 | 🔴 0件 | ✅ 1件 | エラーハンドリングテスト |
| **tests/features** | ✅ 6件 | 🔴 0件 | ✅ 1件 | 個別機能テスト |
| **tests/fixtures** | ✅ 0件 | N/A | N/A | テストデータ管理 |
| **tests/formats** | ✅ 7件 | 🔴 0件 | ✅ 1件 | 出力形式テスト |
| **tests/integration** | ✅ 2件 | 🔴 0件 | 🔴 0件 | 統合テスト専用 |
| **tests/output** | ✅ 0件 | N/A | N/A | 出力検証テスト |
| **総計** | ✅ 131件 | 🔴 0件 | ✅ 6件 | 全テストファイル数 |

**diffx実測値**: Rustテスト117/118成功（99%）、1個失敗（edge_cases::test_empty_files）

### diffai プロジェクト

| テストディレクトリ | Rust CLI | pip package | npm package | 目的 |
|-------------------|----------|-------------|-------------|------|
| **tests/basic** | ✅ 4件 | 🔴 0件 | ✅ 1件 | 基本機能テスト |
| **tests/cli** | ✅ 5件 | 🔴 0件 | ✅ 1件 | CLI動作テスト |
| **tests/core** | ✅ 4件 | N/A | ✅ 1件 | Coreライブラリ・単体テスト |
| **tests/docs_examples** | ✅ 4件 | 🔴 0件 | 🔴 0件 | ドキュメント例示テスト |
| **tests/errors** | ✅ 2件 | 🔴 0件 | ✅ 1件 | エラーハンドリングテスト |
| **tests/features** | ✅ 12件 | 🔴 0件 | ✅ 1件 | 個別機能テスト |
| **tests/fixtures** | ✅ 0件 | N/A | N/A | テストデータ管理 |
| **tests/formats** | ✅ 6件 | 🔴 0件 | ✅ 1件 | 出力形式テスト |
| **tests/integration** | ✅ 2件 | 🔴 0件 | 🔴 0件 | 統合テスト専用 |
| **tests/output** | ✅ 0件 | N/A | N/A | 出力検証テスト |
| **総計** | ✅ 39件 | 🔴 0件 | ✅ 6件 | 全テストファイル数 |

**diffai実測値**: Rustテスト0個実行（unitテスト未実装）、pip/npm実装状況も未確認（テスト未実装）

### lawkit プロジェクト

| テストディレクトリ | Rust CLI | pip package | npm package | 目的 |
|-------------------|----------|-------------|-------------|------|
| **tests/basic** | ✅ 6件 | 🔴 0件 | ✅ 1件 | 基本機能テスト |
| **tests/cli** | ✅ 5件 | 🔴 0件 | ✅ 1件 | CLI動作テスト |
| **tests/core** | ✅ 8件 | N/A | ✅ 1件 | Coreライブラリ・単体テスト |
| **tests/docs_examples** | ✅ 1件 | 🔴 0件 | 🔴 0件 | ドキュメント例示テスト |
| **tests/errors** | ✅ 3件 | 🔴 0件 | ✅ 1件 | エラーハンドリングテスト |
| **tests/features** | ✅ 10件 | 🔴 0件 | ✅ 1件 | 個別機能テスト |
| **tests/fixtures** | ✅ 1件 | N/A | N/A | テストデータ管理 |
| **tests/formats** | ✅ 4件 | 🔴 0件 | ✅ 1件 | 出力形式テスト |
| **tests/integration** | ✅ 0件 | 🔴 0件 | 🔴 0件 | 統合テスト専用 |
| **tests/output** | ✅ 0件 | N/A | N/A | 出力検証テスト |
| **総計** | ✅ 38件 | 🔴 0件 | ✅ 6件 | 全テストファイル数 |

**lawkit実測値**: Rustテスト0個実行（unitテスト未実装）、pip/npm実装状況も未確認（テスト未実装）

---

## 📊 4. テストパス状況マトリクス（引数・オプション別）（実装完了段階）

### diffx テストパス状況（実装形態別）

| 引数・オプション | Rust CLI | Rust Core | pip package | npm package | テストパス率 |
|------------------|----------|-----------|-------------|-------------|-------------|
| **基本引数** |  |  |  |  |  |
| `<INPUT1>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `<INPUT2>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| **基本オプション** |  |  |  |  |  |
| `--help, -h` | ❌ | N/A | 🔍 | 🔍 | 0% |
| `--version, -V` | ❌ | N/A | 🔍 | 🔍 | 0% |
| `--format <FORMAT>, -f` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--output <OUTPUT>, -o` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--recursive, -r` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--quiet, -q` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--brief` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--verbose, -v` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--no-color` | ❌ | N/A | 🔍 | 🔍 | 0% |
| **比較オプション** |  |  |  |  |  |
| `--path <PATH>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--ignore-keys-regex <REGEX>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--epsilon <EPSILON>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--array-id-key <ARRAY_ID_KEY>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--context <CONTEXT>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--ignore-whitespace` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--ignore-case` | ❌ | ❌ | 🔍 | 🔍 | 0% |

**diffx実測値**: Rustテスト117/118成功（99%）、1個失敗のため全オプション❌

### diffai テストパス状況（実装形態別）

| 引数・オプション | Rust CLI | Rust Core | pip package | npm package | テストパス率 |
|------------------|----------|-----------|-------------|-------------|-------------|
| **基本引数** |  |  |  |  |  |
| `<INPUT1>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `<INPUT2>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| **基本オプション** |  |  |  |  |  |
| `--help, -h` | ❌ | N/A | 🔍 | 🔍 | 0% |
| `--version, -V` | ❌ | N/A | 🔍 | 🔍 | 0% |
| `--format <FORMAT>, -f` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--output <OUTPUT>, -o` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--recursive, -r` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--verbose, -v` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--no-color` | ❌ | N/A | 🔍 | 🔍 | 0% |
| **高度オプション** |  |  |  |  |  |
| `--path <PATH>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--ignore-keys-regex <REGEX>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--epsilon <EPSILON>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--array-id-key <ARRAY_ID_KEY>` | ❌ | ❌ | 🔍 | 🔍 | 0% |

**diffai実測値**: Rustテスト0個実行（unitテスト未実装）、pip/npm実装状況も未確認（テスト未実装）

### lawkit テストパス状況（実装形態別）

| 引数・オプション | Rust CLI | Rust Core | pip package | npm package | テストパス率 |
|------------------|----------|-----------|-------------|-------------|-------------|
| **基本引数** |  |  |  |  |  |
| `[input]` (analyze) | ❌ | ❌ | 🔍 | 🔍 | 0% |
| **基本オプション** |  |  |  |  |  |
| `--help, -h` | ❌ | N/A | 🔍 | 🔍 | 0% |
| `--version, -V` | ❌ | N/A | 🔍 | 🔍 | 0% |
| **サブコマンド** |  |  |  |  |  |
| `benf` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `pareto` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `zipf` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `normal` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `poisson` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `analyze` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `validate` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `diagnose` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `generate` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `list` | ❌ | N/A | 🔍 | 🔍 | 0% |
| `selftest` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| **analyze系オプション** |  |  |  |  |  |
| `--format <FORMAT>, -f` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--quiet, -q` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--verbose, -v` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--filter <RANGE>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--min-count <NUMBER>, -c` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--no-color` | ❌ | N/A | 🔍 | 🔍 | 0% |
| `--laws <LAWS>, -l` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--focus <FOCUS>, -F` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--threshold <THRESHOLD>, -t` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--recommend, -r` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--report <TYPE>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--consistency-check` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--cross-validation` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--confidence-level <LEVEL>` | ❌ | ❌ | 🔍 | 🔍 | 0% |
| `--purpose <PURPOSE>, -p` | ❌ | ❌ | 🔍 | 🔍 | 0% |

**lawkit実測値**: Rustテスト0個実行（unitテスト未実装）、pip/npm実装状況も未確認（テスト未実装）

---

## 🔧 5. テストスクリプト実行状況マトリクス（統合検証段階）

### diffx プロジェクト

| テストスクリプト | ローカル実行 | GitHub Actions | 詳細結果 |
|-----------------|-------------|----------------|----------|
| **04-pre-release-test-act1.sh** | 🔍 未実行 | 🔍 未確認 | Rust ecosystem testing |
| **05-pre-release-test-act2.sh** | 🔍 未実行 | 🔍 未確認 | Language wrapper testing |
| **08-test-published-packages.sh** | 🔍 未実行 | 🔍 未確認 | Published packages testing |

### diffai プロジェクト

| テストスクリプト | ローカル実行 | GitHub Actions | 詳細結果 |
|-----------------|-------------|----------------|----------|
| **04-pre-release-test-act1.sh** | 🔍 未実行 | 🔍 未確認 | Rust ecosystem testing |
| **05-pre-release-test-act2.sh** | 🔍 未実行 | 🔍 未確認 | Language wrapper testing |
| **08-test-published-packages.sh** | 🔍 未実行 | 🔍 未確認 | Published packages testing |

### lawkit プロジェクト

| テストスクリプト | ローカル実行 | GitHub Actions | 詳細結果 |
|-----------------|-------------|----------------|----------|
| **04-pre-release-test-act1.sh** | 🔍 未実行 | 🔍 未確認 | Rust ecosystem testing |
| **05-pre-release-test-act2.sh** | 🔍 未実行 | 🔍 未確認 | Language wrapper testing |
| **08-test-published-packages.sh** | 🔍 未実行 | 🔍 未確認 | Published packages testing |

---

**注記**: 
- ✅ = 実測で成功確認済み
- 🔍 = 未確認・要検証
- ❌ = 実測で失敗確認済み
- N/A = 該当実装形態では対象外

この順序でマトリクスを埋めることで、TDDの正しい流れに沿ったリリース準備が可能になります。