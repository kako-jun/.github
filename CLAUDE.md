# Claude Code Work Documentation Index

このリポジトリはClaude Codeによる3プロジェクト（lawkit, diffai, diffx）の統合開発・テスト・リリース作業のドキュメント集です。

## 📋 目次・ナビゲーション

### 🏗️ **Rust CLI プロジェクト関連**
- [`rust-cli-kiln/`](./rust-cli-kiln/) - Rust CLI 3プロジェクト統合管理
  - [設計思想](./rust-cli-kiln/design-philosophy.md) - 3プロジェクト統一の設計理念
  - [コード統一分析](./rust-cli-kiln/code-unification-analysis.md) - 実装パターン統一状況
  - [現在課題分析](./rust-cli-kiln/current-issues-analysis.md) - 識別された課題と対策
  - [テスト網羅分析](./rust-cli-kiln/test-coverage-analysis.md) - テスト完全網羅率達成記録
  - [リリースガイド](./rust-cli-kiln/release-guide.md) - 統合リリースプロセス
  - [包括的マトリクス管理](./rust-cli-kiln/comprehensive-matrix-management.md) - 多次元進捗管理システム
  - [翻訳品質保証プロセス](./rust-cli-kiln/translation-quality-assurance.md) - ネイティブレベル翻訳基準・確認手順
  - [統合開発タスク管理](./rust-cli-kiln/tasks.md) - 包括的作業計画・進捗記録
  - [テスト組織化原則](./rust-cli-kiln/test-organization-principles.md) - 3プロジェクト統一ルール

### 🔧 **自動化スクリプト**
- [`rust-cli-kiln/scripts/`](./rust-cli-kiln/scripts/) - 開発・テスト・リリース自動化
  - **setup/** - 初期環境構築
  - **testing/** - テスト実行・検証
  - **release/** - リリースプロセス自動化
  - **docs/** - ドキュメント整合性チェック
  - **utils/** - 共通ユーティリティ

### 📊 **プロジェクト共通**
- [README.md](./README.md) - このリポジトリの概要
- [profile/README.md](./profile/README.md) - GitHub プロフィール用README

## 🎯 **作業進捗管理**

### ✅ **完了済み作業**
1. **--no-colorオプション統一実装** - 3プロジェクト全体で完了
2. **テストディレクトリ構造統一** - 11種類標準構造に統一
3. **セキュリティ対策** - 機密ファイル保護完了
4. **ドキュメント整理** - 適切なスコープ分離実現

### 🔄 **進行中作業**
- **包括的テスト網羅率100%達成** - マトリクス管理による抜け漏れ防止
- **引数・オプション完全対応表作成** - 3プロジェクト × 4実装形態

### 📋 **次期作業予定**
- **正式リリース準備** - 全テスト完了後
- **継続的統合最適化** - CI/CD パイプライン改善

## 🔍 **マトリクス管理システム**

複雑な作業の抜け漏れ防止のため、2次元マトリクスによる進捗管理を実装：

- **引数・オプション対応表** - 3プロジェクト × 4実装形態
- **テスト網羅マトリクス** - 機能 × テスト種別
- **ドキュメント整合性マトリクス** - 仕様 × 実装 × ドキュメント

詳細は各ドキュメント内の該当セクションを参照してください。

## 🤖 **Claude Code Integration**

このドキュメント群はClaude Codeとの協調作業を前提として設計されており、以下の特徴があります：

- **構造化された情報** - Claude が効率的に理解・参照可能
- **進捗の可視化** - 作業状況の迅速な把握
- **継続性の確保** - セッション間での作業継続性

---

## 🚨 CRITICAL GIT/BASH RULES - NEVER IGNORE

- **ALWAYS use bash -c with directory change** to run commands in different directories: `bash -c "cd /path/to/project && git status"`
- **NEVER create scripts for simple git operations** - use `bash -c "cd /path && git commit ..."` directly
- **NEVER write wrapper scripts** when bash -c can handle the task in one command
- **These rules are ABSOLUTE** and must NEVER be forgotten or ignored

---

## 🎯 diffai 設計哲学・継続方針

**重要**: diffaiでは「ML分析オプション」という概念は存在しない。各ファイル形式で技術的に可能な最大限の分析を**標準機能として自動提供**する。

- `learning_rate_tracking`, `optimizer_comparison`等は実装管理用の識別子
- ユーザーには「PyTorchファイルで自動提供される機能」として説明
- 出力では機能名を区分として使用（可読性・構造化のため）

詳細: `/home/d131/repos/42/2025/diffai/DIFFAI_DESIGN_PHILOSOPHY.md`

---

📝 **最終更新**: Claude Code セッション - diffai設計哲学確立・Phase A2完了時点