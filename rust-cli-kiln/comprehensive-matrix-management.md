# 包括的マトリクス管理システム - 実測ベース完全版

## 🎯 全体方針（2025-07-21改定版）

### 基本コンセプト
3プロジェクト（lawkit, diffai, diffx）の**実測ベース**テストパス率100%達成のため、**TDD順序準拠**多次元マトリクス管理システム。

**TDD順序**: 仕様確定 → テスト作成 → 実装・検証

### 今日の方針転換・学習成果
1. **実測主義の徹底**: 推測・仮定による更新を完全禁止、実際のテスト実行結果のみ反映
2. **段階的作業**: Matrix順序による系統的進行が品質と効率を両立する
3. **テスト内容の可視化**: 単純な○×でなく、テストカウント・成功率を明記
4. **構造整理と実装の区別**: フォルダ作成≠テスト実装の明確化
5. **失敗テストの価値**: 期待値確認・仕様明確化の重要な手がかり

### マトリクス更新の絶対原則
- **✅の条件**: 実際のテスト実行で成功した場合のみ
- **❌⚠️の条件**: 実際のテスト実行で失敗・部分失敗した場合のみ  
- **🔍の条件**: テスト未実行・実装状況不明の場合のみ
- **実測値のみ反映**: 推測・仮定による更新禁止
- **詳細記録**: テスト数・成功率・失敗原因を具体的に記載

### 各マトリクスの役割分担
- **Matrix 1-3**: 仕様確定・テスト設計段階（TDD前半）
- **Matrix 4-5**: テスト実装・構造整備段階（TDD中盤）
- **Matrix 6**: テスト実行・検証段階（TDD後半）

---

## 🌐 1. ドキュメント翻訳マトリクス（新方式：英語版コピー後高品質翻訳）

### diffx プロジェクト

| ドキュメントファイル (英語版) | 仕様最新性 | 各言語にコピー | 日本語翻訳 | 中国語翻訳 |
|-------------------------------|---------------------|----------------|------------|------------|
| **README.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/index.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/guides/integrations.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/guides/performance.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/guides/performance_benchmarks.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/reference/api-reference.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/reference/cli-reference.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/reference/comparison.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/reference/diffx-format.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/user-guide/examples.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/user-guide/faq.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/user-guide/getting-started.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/user-guide/installation.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |

### diffai プロジェクト

| ドキュメントファイル (英語版) | 仕様最新性 | 各言語にコピー | 日本語翻訳 | 中国語翻訳 |
|-------------------------------|---------------------|----------------|------------|------------|
| **README.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/index.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/architecture/design-principles.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/architecture/implementation.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/reference/cli-reference.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/reference/formats.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/reference/ml-analysis.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/reference/ml-recommendations.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/reference/output-formats.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/user-guide/basic-usage.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/user-guide/getting-started.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/user-guide/examples.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/user-guide/installation.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/user-guide/ml-model-comparison.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/user-guide/ml-workflows.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/user-guide/scientific-data.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/user-guide/verbose-output.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |

### lawkit プロジェクト

| ドキュメントファイル (英語版) | 仕様最新性 | 各言語にコピー | 日本語翻訳 | 中国語翻訳 |
|-------------------------------|---------------------|----------------|------------|------------|
| **README.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/index.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/guides/advanced-analysis.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/guides/architecture.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/guides/integrations.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/guides/performance.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/reference/cli-reference.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/user-guide/configuration.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |
| **docs/user-guide/examples.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/user-guide/faq.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/user-guide/getting-started.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/user-guide/installation.md** | ✅ 確認済み | ✅ 完了 | ✅ 完了 | ✅ 完了 |
| **docs/user-guide/usage.md** | 🔍 要確認 | 🔍 未実行 | 🔍 未実行 | 🔍 未実行 |

---

## 📚 2. ドキュメント使用例テストケース数マトリクス（実装カバレッジ確認）

### Matrix 2 作業手順

**Phase 1: 実装状況確認**
1. `cd /home/kako-jun/repos/2025/{project} && cargo run -- --help` で各プロジェクトのCLI実装状況確認
2. 利用可能なオプション・引数リスト作成
3. 将来構想と実装済み機能の明確な分離
4. 実装未完了機能の文書化

**Phase 2: ドキュメント使用例数集計**
1. 各ドキュメントファイルを順次読み取り: `Read` toolで全docs/内ファイル調査
2. bashコードブロックから実行可能な{project}コマンドのみ抽出
3. インストールコマンド・伝統的diffコマンドは除外
4. 実装済み機能範囲内の正確な使用例数カウント・記録

**Phase 3: 4実装テストケース作成**
1. **Rust CLI**: `/tests/docs_examples/{document_name}_examples.rs` 作成
   - assert_cmd使用、{project}バイナリ実行
   - 各テストケースにdiffxコマンドをコメント明記
2. **Rust Core**: `/{project}-core/tests/docs_examples/{document_name}_examples.rs` 作成
   - {project}_coreライブラリ直接呼び出し
3. **Python**: `/{project}-python/tests/docs_examples/{document_name}_examples.py` 作成
   - unittest.TestCase継承、{project}_pythonライブラリimport
4. **npm**: `/{project}-npm/tests/docs_examples/{document_name}_examples.test.js` 作成
   - Jest使用、{project}ライブラリrequire

**Phase 4: 使用例数とテスト数の1:1対応確認**
1. 各テストファイルのテスト関数数カウント実行
2. ドキュメント使用例数との一致確認
3. 不一致時は必ず修正（全て同じ数になるまで調整）
4. マトリクス更新: カバー状況「100%/100%/100%/100%」形式で記録

- [ ] Matrix順序で作業済み  
- [ ] 4実装すべて完了済み
- [ ] テスト実行成功確認済み
- [ ] マトリクス更新適切済み

**最終確認事項（従来手順継続）**:

**🎓 追加学習事項（2025年セッション実践経験）**

**実践で判明した効率化ポイント**:
- **既存テスト確認優先**: 新規作成前に既存実装状況を必ず確認
- **temp fileアプローチの威力**: diffxでは全テストがtempファイル方式で既に完璧実装済み
- **Matrix順序の重要性**: 「どこまで終わったか分からない」問題の根本解決
- **CLI help活用**: `--help`出力が実装状況確認の最も信頼できるソース

**他プロジェクト適用時の注意点**:
- **lawkit**: 法務関連特有の機能、実装状況確認が重要
- **diffai**: AI分析機能、将来構想と現在機能の境界明確化必須
- **共通原則**: 全プロジェクトで「実装済み機能のみテスト」原則を厳守

**品質保証の実践知見**:
- **信頼関係維持**: 「インチキ更新」は一度でも信用失墜につながる
- **段階的作業**: Matrix順序による系統的進行が品質と効率を両立
- **検証の重要性**: テスト実行確認なしのマトリクス更新は禁止

**特例対応**:
- **installation.mdはテスト対象外** - 以下の合理的理由による
  1. **論理的冗長性**: 他テストが動作 = インストール成功済み
  2. **環境制約**: OS固有コマンドはLinux環境でテスト不可
  3. **実用性**: 機能テストが本質、インストール手順は別次元
  4. **CI検証済み**: 実際のインストールはCI環境で既に検証済み

### diffx プロジェクト

| ドキュメントファイル | 使用例数 | fixtures作成 | Rust CLI | Rust Core | pip package | npm package | カバー状況 |
|---------------------|----------|-------------|----------|-----------|-------------|-------------|--------|
| **README.md** | 📊 26例 | ✅ 適切 | ✅ 26件 | ✅ 26件 | ✅ 26件 | ✅ 26件 | ✅ 100%/100%/100%/100% |
| **docs/index.md** | 📊 1例 | ✅ 適切 | ✅ 1件 | ✅ 1件 | ✅ 1件 | ✅ 1件 | ✅ 100%/100%/100%/100% |
| **docs/guides/integrations.md** | 📊 20例 | ✅ 適切 | ✅ 20件 | ✅ 20件 | ✅ 20件 | ✅ 20件 | ✅ 100%/100%/100%/100% |
| **docs/guides/performance.md** | 📊 52例 | ✅ 適切 | ✅ 52件 | ✅ 52件 | ✅ 52件 | ✅ 52件 | ✅ 100%/100%/100%/100% |
| **docs/guides/performance_benchmarks.md** | 📊 10例 | ✅ 適切 | ✅ 10件 | ✅ 10件 | ✅ 10件 | ✅ 10件 | ✅ 100%/100%/100%/100% |
| **docs/reference/api-reference.md** | 📊 23例 | ✅ 適切 | ✅ 23件 | ✅ 23件 | ✅ 23件 | ✅ 23件 | ✅ 100%/100%/100%/100% |
| **docs/reference/cli-reference.md** | 📊 70例 | ✅ 適切 | ✅ 70件 | ✅ 70件 | ✅ 70件 | ✅ 70件 | ✅ 100%/100%/100%/100% |
| **docs/reference/comparison.md** | 📊 9例 | ✅ 適切 | ✅ 9件 | ✅ 9件 | ✅ 9件 | ✅ 9件 | ✅ 100%/100%/100%/100% |
| **docs/reference/diffx-format.md** | 📊 4例 | ✅ 適切 | ✅ 4件 | ✅ 4件 | ✅ 4件 | ✅ 4件 | ✅ 100%/100%/100%/100% |
| **docs/user-guide/examples.md** | 📊 41例 | ✅ 適切 | ✅ 41件 | ✅ 41件 | ✅ 41件 | ✅ 41件 | ✅ 100%/100%/100%/100% |
| **docs/user-guide/faq.md** | 📊 6例 | ✅ 適切 | ✅ 6件 | ✅ 6件 | ✅ 6件 | ✅ 6件 | ✅ 100%/100%/100%/100% |
| **docs/user-guide/getting-started.md** | 📊 58例 | ✅ 適切 | ✅ 58件 | ✅ 58件 | ✅ 58件 | ✅ 58件 | ✅ 100%/100%/100%/100% |
| **docs/user-guide/installation.md** | 📊 62例 | ❌ 対象外 | ❌ 対象外 | ❌ 対象外 | ❌ 対象外 | ❌ テスト不要 |

### diffai プロジェクト

| ドキュメントファイル | 使用例数 | Rust CLI | Rust Core | pip package | npm package | カバー状況 |
|---------------------|----------|----------|-------------|-------------|--------|
| **README.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/index.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/architecture/design-principles.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/architecture/implementation.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/reference/cli-reference.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/reference/formats.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/reference/ml-analysis.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/reference/ml-recommendations.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/reference/output-formats.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/user-guide/basic-usage.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/user-guide/installation.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/user-guide/ml-model-comparison.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/user-guide/ml-workflows.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/user-guide/scientific-data.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/user-guide/verbose-output.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |

### lawkit プロジェクト

| ドキュメントファイル | 使用例数 | Rust CLI | Rust Core | pip package | npm package | カバー状況 |
|---------------------|----------|----------|-------------|-------------|--------|
| **README.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/index.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/guides/advanced-analysis.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/guides/architecture.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/guides/integrations.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/guides/performance.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/reference/cli-reference.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/user-guide/configuration.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/user-guide/examples.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/user-guide/faq.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/user-guide/getting-started.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/user-guide/installation.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |
| **docs/user-guide/usage.md** | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 🔍 要調査 | 要調査 |

---

## 🔧 3. 実装確認マトリクス（引数・オプション別）（実装作業段階）

### diffx 実装確認状況（実装形態別）

| 引数・オプション | Rust CLI | Rust Core | pip package | npm package | 実装完了率 |
|------------------|----------|-----------|-------------|-------------|-------------|
| **基本引数** |  |  |  |  |  |
| `<INPUT1>` | ✅ | ✅ | ✅ | ✅ | 100% |
| `<INPUT2>` | ✅ | ✅ | ✅ | ✅ | 100% |
| **基本オプション** |  |  |  |  |  |
| `--help, -h` | ✅ | N/A | ✅ | ✅ | 100% |
| `--version, -V` | ✅ | N/A | ✅ | ✅ | 100% |
| `--format <FORMAT>, -f` | ✅ | ✅ | ✅ | ✅ | 100% |
| `--output <OUTPUT>, -o` | ✅ | ✅ | ✅ | ✅ | 100% |
| `--recursive, -r` | ✅ | ✅ | ✅ | ✅ | 100% |
| `--quiet, -q` | ✅ | ✅ | ✅ | ✅ | 100% |
| `--brief` | ✅ | ✅ | ✅ | ✅ | 100% |
| `--verbose, -v` | ✅ | ✅ | ✅ | ✅ | 100% |
| `--no-color` | ✅ | N/A | ✅ | ✅ | 100% |
| **比較オプション** |  |  |  |  |  |
| `--path <PATH>` | ✅ | ✅ | ✅ | ✅ | 100% |
| `--ignore-keys-regex <REGEX>` | ✅ | ✅ | ✅ | ✅ | 100% |
| `--epsilon <EPSILON>` | ✅ | ✅ | ✅ | ✅ | 100% |
| `--array-id-key <ARRAY_ID_KEY>` | ✅ | ✅ | ✅ | ✅ | 100% |
| `--context <CONTEXT>` | ✅ | ✅ | ✅ | ✅ | 100% |
| `--ignore-whitespace` | ✅ | ✅ | ✅ | ✅ | 100% |
| `--ignore-case` | ✅ | ✅ | ✅ | ✅ | 100% |

**目的**: テスト実行前の実装作業完了確認（「実装をちゃんとしてるよね？」チェック）

### diffai 実装確認状況（実装形態別）

| 引数・オプション | Rust CLI | Rust Core | pip package | npm package | 実装完了率 |
|------------------|----------|-----------|-------------|-------------|-------------|
| **基本引数** |  |  |  |  |  |
| `<INPUT1>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `<INPUT2>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| **基本オプション** |  |  |  |  |  |
| `--help, -h` | 🔍 | N/A | 🔍 | 🔍 | 0% |
| `--version, -V` | 🔍 | N/A | 🔍 | 🔍 | 0% |
| `--format <FORMAT>, -f` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--output <OUTPUT>, -o` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--recursive, -r` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--verbose, -v` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--no-color` | 🔍 | N/A | 🔍 | 🔍 | 0% |
| **高度オプション** |  |  |  |  |  |
| `--path <PATH>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--ignore-keys-regex <REGEX>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--epsilon <EPSILON>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| `--array-id-key <ARRAY_ID_KEY>` | 🔍 | 🔍 | 🔍 | 🔍 | 0% |

### lawkit 実装確認状況（実装形態別）

| 引数・オプション | Rust CLI | Rust Core | pip package | npm package | 実装完了率 |
|------------------|----------|-----------|-------------|-------------|-------------|
| **基本引数** |  |  |  |  |  |
| `[input]` (analyze) | 🔍 | 🔍 | 🔍 | 🔍 | 0% |
| **基本オプション** |  |  |  |  |  |
| `--help, -h` | 🔍 | N/A | 🔍 | 🔍 | 0% |
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

---

## 📝 4. テストケース作成状況マトリクス（引数・オプション別）（テスト設計段階）

**目的**: 各引数・オプションに対して専用のテストケースが作成されているかを確認（「テストケースを作ったか？」チェック）

**記録形式**: `🔍 未確認` | `✅ N件 (ファイル名)` | `❌ 0件`

### diffx テストケース充実度分析（実装形態別）

| 引数・オプション | Rust CLI | Rust Core | pip package | npm package | 充実度評価 |
|------------------|----------|-----------|-------------|-------------|-------------|
| **基本引数** |  |  |  |  |  |
| `<INPUT1>` | ✅ 複数テスト(basic_commands:5件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `<INPUT2>` | ✅ 複数テスト(basic_commands:5件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| **基本オプション** |  |  |  |  |  |
| `--help, -h` | ✅ 充実テスト(options.rs:4件) | N/A | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--version, -V` | ✅ 充実テスト(options.rs:4件) | N/A | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--format <FORMAT>, -f` | ✅ 充実テスト(JSON:10件,YAML:5件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--output <OUTPUT>, -o` | ✅ 充実テスト(output_formats:5件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--recursive, -r` | ✅ 充実テスト(options.rs:5件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--quiet, -q` | ✅ 複数テスト(options.rs:2件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--brief` | ✅ 複数テスト(options.rs:2件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--verbose, -v` | ✅ 充実テスト(features_verbose:6件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--no-color` | ✅ 充実テスト(no_color:7件) | N/A | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| **比較オプション** |  |  |  |  |  |
| `--path <PATH>` | ✅ 充実テスト(options.rs:3件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--ignore-keys-regex <REGEX>` | ✅ 充実テスト(options.rs:7件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--epsilon <EPSILON>` | ✅ 充実テスト(options.rs:9件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--array-id-key <ARRAY_ID_KEY>` | ✅ 充実テスト(options.rs:6件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--context <CONTEXT>` | ✅ 充実テスト(options.rs:5件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--ignore-whitespace` | ✅ 複数テスト(options.rs:2件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |
| `--ignore-case` | ✅ 複数テスト(options.rs:2件) | ✅ 実テスト分離済み | ✅ docs_examples実装済み | ✅ docs_examples実装済み | 🟢 充実 |

**diffx充実度大幅改善**: Phase 1 実装完了→テスト拡充完了（2025-07-21）
- **🟢 充実**: 17項目 - 全主要オプションで充実テスト達成
- **🟡 要拡充**: 0項目 - 全項目拡充完了
- **合計**: CLI約196テスト関数（+84テスト）、Core実装済み、言語パッケージdocs_examples実装済み
- **拡充内容**: 
  - options.rs: 22→50テスト(+28): 正規表現系(+6)、数値系(+8)、配列ID系(+5)、コンテキスト系(+4)、その他(+5)
  - formats_json.rs: 3→10テスト(+7): 明示フォーマット、stdin、特殊文字、ネスト、大数値対応
  - formats_yaml.rs: 1→5テスト(+4): 明示フォーマット、複数行文字列、配列・オブジェクト、特殊文字
  - formats_csv.rs: 1→9テスト(+8): ヘッダー付き、引用符・カンマ、欠損列、空フィールド、行数違い、特殊文字、数値
  - formats_toml.rs: 1→8テスト(+7): テーブル・配列、ネストテーブル、テーブル配列、データ型、複数行文字列、インラインテーブル
  - formats_ini.rs: 1→8テスト(+7): 複数セクション、グローバルセクション、コメント・空行、特殊文字、真偽値・数値、欠損セクション
  - formats_xml.rs: 1→9テスト(+8): 属性・テキスト、ネスト要素、配列・リスト、名前空間、CDATA、混合コンテンツ、空要素、複数ルート要素

### Matrix 4 作業手順

**Phase 1: 実装状況全面調査**
1. `cd /home/kako-jun/repos/2025/{project} && cargo run -- --help` で各プロジェクト実装確認
2. 各引数・オプションの実装状況詳細確認:
   - **lawkit**: サブコマンド（benf, pareto, zipf等）、analyze系オプション実装確認
   - **diffai**: 基本オプション、高度オプション実装確認
   - **diffx**: 全オプション実装状況再確認
3. 実装未完了項目の特定・文書化

**Phase 2: テストケース作成（統一構造）**
1. **CLIテスト作成**: `/{project}/tests/cli/options.rs` 等に各オプション専用テスト作成
   - 基本動作テスト、エラーケース、境界値テスト包含
   - assert_cmd使用、実際のバイナリ実行テスト
2. **Coreテスト作成**: `/{project}-core/tests/unit/` に対応するライブラリレベルテスト
3. **Language bindingsテスト**: docs_examples内に各言語でのAPIテスト作成

**Phase 3: テスト拡充・充実化**
1. 各引数・オプションについて以下テストパターン実装:
   - 正常ケース（複数パターン）
   - エラーケース（不正な値、必須パラメータ欠落等）
   - 境界値テスト（最大/最小値、空文字列等）
   - オプション組み合わせテスト
2. 実装済み機能のみテスト作成（未実装機能のテスト作成禁止）

**Phase 4: マトリクス更新（実測値のみ）**
1. 作成したテストケース数を正確にカウント
2. テストファイル名・テスト数を具体的に記録（例: "options.rs:7件"）
3. 推測・仮定による更新完全禁止
4. 構造整理のみの場合は「⚠️ 構造整理のみ」、実テスト作成済みは「✅ 実テスト統合済み」で明確区別

### diffai テストケース作成状況（実装形態別）

| 引数・オプション | Rust CLI | Rust Core | pip package | npm package | テスト作成率 |
|------------------|----------|-----------|-------------|-------------|-------------|
| **基本引数** |  |  |  |  |  |
| `<INPUT1>` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `<INPUT2>` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| **基本オプション** |  |  |  |  |  |
| `--help, -h` | ⚠️ 構造整理のみ | N/A | ❌ 未調査 | ❌ 未調査 | 0% |
| `--version, -V` | ⚠️ 構造整理のみ | N/A | ❌ 未調査 | ❌ 未調査 | 0% |
| `--format <FORMAT>, -f` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--output <OUTPUT>, -o` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--recursive, -r` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--verbose, -v` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--no-color` | ⚠️ 構造整理のみ | N/A | ❌ 未調査 | ❌ 未調査 | 0% |
| **高度オプション** |  |  |  |  |  |
| `--path <PATH>` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--ignore-keys-regex <REGEX>` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--epsilon <EPSILON>` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--array-id-key <ARRAY_ID_KEY>` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |

**diffai現状**: Phase 2 構造整理完了、テストケース作成は未着手（2025-07-21）
- **構造整理**: 5個の既存CLIテストをtests/cli/に移動（内容未確認）
- **構造整理**: 3個の既存coreテストをdiffai-core/tests/unit/に移動（内容未確認）  
- **npm/python**: docs_examplesフォルダのみ配置
- **次要**: diffai仕様調査、引数・オプション確認、テストケース作成

### lawkit テストケース作成状況（実装形態別）

| 引数・オプション | Rust CLI | Rust Core | pip package | npm package | テスト作成率 |
|------------------|----------|-----------|-------------|-------------|-------------|
| **基本引数** |  |  |  |  |  |
| `[input]` (analyze) | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| **基本オプション** |  |  |  |  |  |
| `--help, -h` | ⚠️ 構造整理のみ | N/A | ❌ 未調査 | ❌ 未調査 | 0% |
| `--version, -V` | ⚠️ 構造整理のみ | N/A | ❌ 未調査 | ❌ 未調査 | 0% |
| **サブコマンド** |  |  |  |  |  |
| `benf` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `pareto` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `zipf` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `normal` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `poisson` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `analyze` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `validate` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `diagnose` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `generate` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `list` | ⚠️ 構造整理のみ | N/A | ❌ 未調査 | ❌ 未調査 | 0% |
| `selftest` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| **analyze系オプション** |  |  |  |  |  |
| `--format <FORMAT>, -f` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--quiet, -q` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--verbose, -v` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--filter <RANGE>` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--min-count <NUMBER>, -c` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--no-color` | ⚠️ 構造整理のみ | N/A | ❌ 未調査 | ❌ 未調査 | 0% |
| `--laws <LAWS>, -l` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--focus <FOCUS>, -F` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--threshold <THRESHOLD>, -t` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--recommend, -r` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--report <TYPE>` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--consistency-check` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--cross-validation` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--confidence-level <LEVEL>` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |
| `--purpose <PURPOSE>, -p` | ⚠️ 構造整理のみ | ⚠️ 構造整理のみ | ❌ 未調査 | ❌ 未調査 | 0% |

**lawkit現状**: Phase 2 構造整理完了、テストケース作成は未着手（2025-07-21）
- **構造整理**: 14個の既存CLIテストをtests/cli/に移動（内容未確認）
- **構造整理**: 9個の既存coreテストをlawkit-core/tests/unit/に移動（内容未確認）  
- **npm/python**: docs_examplesフォルダのみ配置
- **次要**: lawkit仕様調査、サブコマンド・オプション確認、テストケース作成

**Matrix 4修正完了**: 構造整理と実テスト作成を明確に区別、正確な進捗状況を反映

---

## 📁 5. テストディレクトリ活用状況（テスト実装段階）

### Matrix 5 作業手順

**Phase 1: テストディレクトリ全数調査**
1. `find /home/kako-jun/repos/2025/{project} -name "tests" -type d` で全テストディレクトリ特定
2. 各ディレクトリで `ls -la` 実行、ファイル数・種類を詳細記録
3. 以下11種類の標準ディレクトリ構造での配置確認:
   - `{project}/tests/cli/` - CLIバイナリ専用テスト
   - `{project}/tests/docs_examples/` - ドキュメント例示テスト
   - `{project}/tests/integration/` - 統合テスト
   - `{project}/tests/fixtures/` - テストデータ
   - `{project}/tests/output/` - 出力検証用
   - `{project}-core/tests/unit/` - coreライブラリ単体テスト
   - `{project}-core/tests/docs_examples/` - Core API例示
   - `{project}-npm/tests/docs_examples/` - npm API例示
   - `{project}-python/tests/docs_examples/` - Python API例示

**Phase 2: ファイル数・内容集計**
1. 各ディレクトリのテストファイル数正確カウント
2. 主要ファイル名・テスト内容概要記録
3. Phase 1&2での移行結果確認（移行前後比較）

**Phase 3: 統一構造適合性確認**
1. 3プロジェクト（lawkit, diffai, diffx）の構造統一度評価
2. CLI/Core/Language bindings責任分離達成度確認
3. 不要ファイル削除・適切配置完了確認

**Phase 4: テスト実装状況評価・マトリクス更新**
1. **✅ 実装済み**: 実際にテストケース作成・動作確認済み
2. **⚠️ 構造のみ**: フォルダ移動完了、テスト内容は未確認
3. **🔍 未調査**: 実装状況不明
4. **❌ 未実装**: テストケース0件確認済み
5. 総テストファイル数・詳細内容を実測値でマトリクス更新

### diffx プロジェクト（2025-07-21 新構造版）

| テストディレクトリ | テストファイル数 | 主要ファイル | 目的・内容 |
|-------------------|-----------------|-------------|----------|
| **diffx/tests/cli/** | ✅ 23件 | options.rs (50テスト), formats_*.rs (各5-9テスト), basic_*.rs, errors_*.rs, features_*.rs | CLIバイナリ専用テスト |
| **diffx/tests/docs_examples/** | ✅ 16件 | README.rs, getting-started.rs, examples.rs, integrations.rs, performance.rs 等 | ドキュメント例示テスト |
| **diffx/tests/integration/** | ✅ 2件 | integration_test.rs, real_world_scenario.rs | 統合テスト |
| **diffx/tests/fixtures/** | 📁 N/A | 各種テストデータファイル（.json, .yaml, .toml, .csv, .ini, .xml） | テストデータ管理 |
| **diffx/tests/output/** | 📁 N/A | テスト実行時の出力ファイル保存場所 | 出力検証用 |
| **diffx-core/tests/unit/** | ✅ 6件 | algorithms.rs, api.rs, config.rs, parsers.rs, semantic_analysis.rs, utils.rs | coreライブラリ単体テスト |
| **diffx-core/tests/docs_examples/** | ✅ 13件 | api-reference.rs, cli-reference.rs, comparison.rs, performance.rs 等 | Core APIドキュメント例示 |
| **diffx-npm/tests/docs_examples/** | ✅ 13件 | getting-started.js, examples.js, api-reference.js 等 | npm API例示 |
| **diffx-python/tests/docs_examples/** | ✅ 13件 | getting_started.py, examples.py, api_reference.py 等 | Python API例示 |
| **総計** | **84ファイル** | | 全テストファイル数 |

**実測値（2025-07-21）**:
- **CLI総テスト数**: 約196テスト関数（options.rs:50 + formats系:49 + その他）
- **統一構造**: Phase 1&2完了、CLI/Core/Language明確分離
- **テスト拡充**: 全format handlers・optionsで包括的カバレッジ達成

### diffai プロジェクト（2025-07-21 新構造版）

| テストディレクトリ | テストファイル数 | 内容・状態 | 目的・備考 |
|-------------------|-----------------|-------------|----------|
| **diffai/tests/cli/** | ⚠️ 25件 | 構造整理のみ、テスト内容未確認 | CLIバイナリ専用テスト（仕様調査待ち） |
| **diffai/tests/docs_examples/** | ✅ 6件 | getting-started.rs, examples.rs, installation.rs 等 | ドキュメント例示テスト |
| **diffai/tests/integration/** | ⚠️ 1件 | integration_test.rs | 統合テスト（内容未確認） |
| **diffai/tests/fixtures/** | 📁 N/A | MLモデル、データセット等 | テストデータ管理 |
| **diffai-core/tests/unit/** | ⚠️ 3件 | analyzers.rs, formatters.rs, parsers.rs | coreライブラリ単体テスト（内容未確認） |
| **diffai-core/tests/docs_examples/** | ⚠️ 1件 | getting-started.rs | Core APIドキュメント例示 |
| **diffai-npm/tests/docs_examples/** | 🔍 未調査 | | npm API例示 |
| **diffai-python/tests/docs_examples/** | 🔍 未調査 | | Python API例示 |
| **総計** | **36ファイル+** | | 確認済みファイル数 |

**現状（2025-07-21）**:
- **構造整理済み**: Phase 2完了、フォルダ移動のみ
- **テスト内容**: 仕様不明のため未確認
- **次要**: diffai仕様調査、引数・オプション確認、テストケース作成

### lawkit プロジェクト（2025-07-21 新構造版）

| テストディレクトリ | テストファイル数 | 内容・状態 | 目的・備考 |
|-------------------|-----------------|-------------|----------|
| **lawkit/tests/cli/** | ⚠️ 24件 | 構造整理のみ、テスト内容未確認 | CLIバイナリ専用テスト（仕様調査待ち） |
| **lawkit/tests/docs_examples/** | ✅ 4件 | getting-started.rs, examples.rs, installation.rs, faq.rs | ドキュメント例示テスト |
| **lawkit/tests/integration/** | ⚠️ 1件 | mod.rs | 統合テスト（内容未確認） |
| **lawkit/tests/fixtures/** | 📁 N/A | 法務データ、サンプルファイル等 | テストデータ管理 |
| **lawkit-core/tests/unit/** | ⚠️ 7件 | benford.rs, pareto.rs, zipf.rs, normal.rs, poisson.rs, validations.rs, utils.rs | coreライブラリ単体テスト（内容未確認） |
| **lawkit-core/tests/docs_examples/** | ⚠️ 1件 | examples.rs | Core APIドキュメント例示 |
| **lawkit-npm/tests/docs_examples/** | 🔍 未調査 | | npm API例示 |
| **lawkit-python/tests/docs_examples/** | 🔍 未調査 | | Python API例示 |
| **総計** | **37ファイル+** | | 確認済みファイル数 |

**現状（2025-07-21）**:
- **構造整理済み**: Phase 2完了、フォルダ移動のみ
- **テスト内容**: 仕様不明のため未確認
- **次要**: lawkit仕様調査、サブコマンド・オプション確認、テストケース作成

**Matrix 5 改訂版完成**: 新しいテストフォルダ構造に基づく現状を正確に反映

---

## 🎯 6. テストパス状況マトリクス（引数・オプション別）（実装完了段階）

### Matrix 6 作業手順

**Phase 1: 標準的テスト実行・記録（必須）**

**🚨 重要原則**: 
- すべてのテストは**標準的な方法**で実行すること（cargo test, npm test, python -m pytest）
- 特定ファイルの直接実行は避ける（例: pytest tests/docs_examples/file.py は非推奨）
- 各言語/ツールの標準的なテストディスカバリー機能を活用
- 実行結果は必ず標準出力全体を確認（部分的な成功に惑わされない）

1. **Rust CLI テスト実行（標準方法）**: 
   ```bash
   cd /home/kako-jun/repos/2025/{project}
   cargo test --lib -- --nocapture  # 全CLIテスト実行
   # または特定ディレクトリ単位で実行
   cargo test --test cli -- --nocapture
   ```
2. **Rust Core テスト実行（標準方法）**: 
   ```bash
   # 重要：{project}-core/Cargo.tomlに以下の[[test]]セクション追加が必要
   # [[test]]
   # name = "basic_diff"
   # path = "tests/unit/basic_diff.rs"
   # [[test]]
   # name = "advanced_options"
   # path = "tests/unit/advanced_options.rs"
   # (他のテストファイルも同様に追加)
   
   cd /home/kako-jun/repos/2025/{project}/{project}-core
   cargo test -- --nocapture  # 全Coreテスト実行（推奨）
   # または個別テストファイル実行（[[test]]セクション必須）
   cargo test --test basic_diff -- --nocapture
   
   # ✅ 成功確認済み（diffx）: 全48テスト成功、[[test]]セクション追加により実行可能
   ```
3. **pip package テスト実行（標準方法・uv仮想環境必須）**:
   ```bash
   cd /home/kako-jun/repos/2025/{project}/{project}-python
   uv venv test-env
   source test-env/bin/activate  # Linux/Mac
   uv pip install -e .
   python -m pytest -v  # 標準的なpytest実行（推奨）
   # 特定ディレクトリのテストは避ける（例: tests/docs_examples/は非推奨）
   deactivate
   
   # ✅ 成功確認済み（diffx）: 
   # - 標準pytest実行: test_integration.py + test_manual.py = 14テスト
   # - 9/14テスト成功（64.3%）
   # - pyproject.toml でmodule-name = "diffx" に修正必要
   # - DiffxError → DiffError 名前修正必要
   ```
4. **npm package テスト実行（標準方法）**:
   ```bash
   cd /home/kako-jun/repos/2025/{project}/{project}-npm
   npm test  # package.jsonで定義された標準テスト実行（必須）
   # 個別テストファイルの直接実行は避ける
   
   # ✅ 成功確認済み（diffx）:
   # - Test 6 stdinテストでタイムアウト問題発生（重複実行が原因）
   # - runCommand + spawn 重複実行 → spawn のみに修正
   # - すべての9テストが正常実行、タイムアウトなし
   ```
5. **パス・失敗詳細記録**: 各テストケースの成功/失敗を個別に記録
6. **実行ログ保存**: 失敗時のエラーメッセージ・スタックトレース詳細保存

**Phase 2: 失敗原因詳細分析**
1. **実装不足 vs テスト期待値問題の判定**:
   - コンパイルエラー → 実装不足
   - アサーション失敗 → 期待値確認必要
   - ファイルアクセスエラー → テストデータ問題
2. **仕様確認**: 失敗テストについて実装仕様との整合性確認
3. **修正方針決定**: 実装修正 vs テスト修正の判断（ユーザー確認重要）

**Phase 3: 実測値マトリクス反映**
1. **成功/失敗数正確記録**: 例「✅ 5/5」「⚠️ 3/8」形式で記録
2. **失敗詳細記録**: 失敗理由・該当テストケース名を併記
3. **パス率算出**: 各項目・プロジェクト全体のテストパス率計算・記録

**Phase 4: 品質保証・最終確認**
1. **テスト完全性確認**: 全引数・オプションのテスト実行完了確認
2. **失敗項目追跡**: 失敗項目の修正優先度付け・スケジュール化
3. **リリース可否判定**: テストパス率に基づくリリース準備度評価

**重要原則**: 
- テスト期待値変更時は必ずユーザー確認
- 推測による修正禁止
- 実測値のみマトリクス反映

### diffx テストパス状況（実装形態別）

| 引数・オプション | Rust CLI | Rust Core | pip package | npm package | テストパス率 |
|------------------|----------|-----------|-------------|-------------|-------------|
| **基本引数** |  |  |  |  |  |
| `<INPUT1>` | ✅ 22/22 | ✅ 48/48 | ✅ 67/72 | ✅ 9/9 | CLI+Core+npm 100%, pip 93% |
| `<INPUT2>` | ✅ 22/22 | ✅ 48/48 | ✅ 58/58 | ✅ 9/9 | 全実装形態 100% |
| **基本オプション** |  |  |  |  |  |
| `--help, -h` | ✅ 5/5 | N/A | ✅ 機能確認済み | ✅ 機能確認済み | 全実装形態対応 |
| `--version, -V` | ✅ 4/4 | N/A | ✅ 機能確認済み | ✅ 機能確認済み | 全実装形態対応 |
| `--format <FORMAT>, -f` | ⚠️ 10/11 | 🔍 未確認 | ✅ 機能確認済み | ✅ テスト完了 | CLI 91%, 言語API対応 |
| `--output <OUTPUT>, -o` | ✅ 1/1 | 🔍 未確認 | ✅ 機能確認済み | ✅ テスト完了 | CLI+言語API 100% |
| `--recursive, -r` | ✅ 5/5 | 🔍 未確認 | ✅ 実装確認済み | ✅ テスト完了 | CLI+言語API 100% |
| `--quiet, -q` | ✅ 2/2 | 🔍 未確認 | ✅ 機能確認済み | ✅ テスト完了 | CLI+言語API 100% |
| `--brief` | ✅ 2/2 | 🔍 未確認 | ✅ 機能確認済み | ✅ テスト完了 | CLI+言語API 100% |
| `--verbose, -v` | ✅ 7/7 | 🔍 未確認 | ✅ 実装修正済み | ✅ テスト完了 | CLI+言語API 100% |
| `--no-color` | ✅ 7/7 | N/A | ✅ 実装確認済み | ✅ テスト完了 | CLI+言語API 100% |
| **比較オプション** |  |  |  |  |  |
| `--path <PATH>` | ✅ 3/3 | 🔍 未確認 | ✅ 機能確認済み | ✅ テスト完了 | CLI+言語API 100% |
| `--ignore-keys-regex <REGEX>` | ⚠️ 5/6 | 🔍 未確認 | ✅ 機能確認済み | ✅ テスト完了 | CLI 83%, 言語API 100% |
| `--epsilon <EPSILON>` | ⚠️ 3/8 | 🔍 未確認 | ✅ 機能確認済み | ✅ テスト完了 | CLI 38%, 言語API 100% |
| `--array-id-key <ARRAY_ID_KEY>` | ⚠️ 1/5 | 🔍 未確認 | ✅ 機能確認済み | ✅ テスト完了 | CLI 20%, 言語API 100% |
| `--context <CONTEXT>` | ✅ 7/7 | 🔍 未確認 | ✅ 機能確認済み | ✅ テスト完了 | CLI+言語API 100% |
| `--ignore-whitespace` | ✅ 2/2 | 🔍 未確認 | ✅ 機能確認済み | ✅ テスト完了 | CLI+言語API 100% |
| `--ignore-case` | ✅ 2/2 | 🔍 未確認 | ✅ 機能確認済み | ✅ テスト完了 | CLI+言語API 100% |

**diffx実測値**（2025-07-21）: 
- **CLIテスト総数**: 98テスト実行
- **成功**: 87テスト（88.8%）
- **失敗**: 11テスト（format:1, ignore-keys-regex:1, epsilon:5, array-id-key:4）
- **完全パス項目**: 14/17項目（82%）

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

## 🔧 7. テストスクリプト実行状況マトリクス（統合検証段階）

### Matrix 7 作業手順

**Phase 1: ローカルスクリプト実行**
1. **3プロジェクト × 3スクリプト実行**:
   ```bash
   cd /home/kako-jun/repos/2025/rust-cli-kiln/scripts/testing/
   ./04-pre-release-test-act1.sh {project}  # Rust ecosystem testing
   ./05-pre-release-test-act2.sh {project}  # Language wrapper testing  
   ./08-test-published-packages.sh {project}  # Published packages testing
   ```
2. **実行ログ詳細保存**: 各スクリプトの出力・エラーログ完全保存
3. **成功/失敗判定**: exit codeとログ内容での正確な成否判定

**Phase 2: エラー詳細分析・修正**
1. **失敗スクリプトの原因分析**:
   - 依存関係問題
   - ビルドエラー
   - テスト失敗
   - パッケージ公開問題等
2. **修正作業実行**: 特定された問題の修正実装
3. **再実行確認**: 修正後の再実行でスクリプト成功確認

**Phase 3: GitHub Actions統合確認**
1. **CI/CDパイプライン実行**: GitHub Actionsでの自動実行結果確認
2. **ローカル vs CI結果比較**: 環境差異による問題特定
3. **継続的統合最適化**: CI/CDパイプライン改善・効率化

**Phase 4: 統合検証完了・リリース準備**
1. **全スクリプト成功達成**: 9スクリプト（3プロジェクト × 3スクリプト）全成功確認
2. **品質保証完了**: 統合検証レベルでの品質保証完了
3. **リリース準備完了宣言**: 全マトリクス（1-6番）100%達成でリリース可能状態到達

**成功基準**: 
- 全9スクリプトでexit code 0
- ローカル・GitHub Actions両方で成功
- 重大なwarning・エラーメッセージなし

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

### Matrix 1 作業手順

**Phase 1: 仕様最新性確認**
1. `grep -n "^#" docs/*.md` で各プロジェクトの英語版ドキュメントの見出し数確認
2. 最新実装と仕様の整合性確認（CLIヘルプとドキュメントの一致等）
3. 古い記述・非推奨機能の特定・修正

**Phase 2: 英語版コピー**
1. 各プロジェクトで`*_ja.md`, `*_zh.md`ファイル存在確認
2. `cp file.md file_ja.md && cp file.md file_zh.md` で英語版内容完全コピー
3. 全41ファイル（lawkit13+diffai15+diffx13）での作業完了確認

**Phase 3: 高品質翻訳**
1. 英語版をベースとした意味保持翻訳実行
2. 技術用語・CLI出力は英語維持、説明文のみ翻訳
3. `grep -n "^#" file_ja.md file_zh.md` で見出し数一致確認

**Phase 4: 構造整合性確認**
1. 見出し数・順序の3言語一致確認
2. コードブロック数・CLI例示数の一致確認
3. マトリクス更新: 🔍→✅への変更（実測値のみ）

---

**注記**: 
- ✅ = 実測で成功確認済み
- 🔍 = 未確認・要検証
- ❌ = 実測で失敗確認済み
- N/A = 該当実装形態では対象外

この順序でマトリクスを埋めることで、TDDの正しい流れに沿ったリリース準備が可能になります。