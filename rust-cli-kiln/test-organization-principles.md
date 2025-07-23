# テスト組織化原則 - 3プロジェクト統一ルール

## 🎯 基本原則

### 1. **分類表現方法の統一**
- **Rust**: サブフォルダで分類表現 (`tests/basic/`, `tests/cli/`, `tests/core/`, `tests/integration/`, `tests/features/`, `tests/formats/`, `tests/errors/`, `tests/docs_examples/`)
- **pip (Python)**: **サブフォルダで分類表現** (`tests/basic/`, `tests/cli/`, `tests/core/`, `tests/integration/`, `tests/features/`, `tests/formats/`, `tests/errors/`, `tests/docs_examples/`)
- **npm (Node.js)**: **サブフォルダで分類表現** (`tests/basic/`, `tests/cli/`, `tests/core/`, `tests/integration/`, `tests/features/`, `tests/formats/`, `tests/errors/`, `tests/docs_examples/`)

### 2. **機能同等性の原則**
- npmとpipは言語が違うだけで、**Rustバイナリの機能をimportして呼び出す**点で同じ
- よって**テスト項目はほぼ同じになる**
- 分類した結果できる**ファイルの数も同じになる**
- 分類をアルファベットで表現した結果である**ファイル名も実質同じになる**

### 3. **言語慣習準拠**
- 各言語での慣習に従った命名規則を使用
- **完全に同じファイル名ではないが、実質同じ分類**
- Python: `test_*.py` 形式
- Node.js: `*.test.js` 形式

### 4. **標準サブディレクトリ分類**
すべてのpip/npmパッケージは以下のサブディレクトリ構造でテストを作成（Rust準拠）：

| 分類 | pip (Python) | npm (Node.js) | Rust (参照) | 目的 |
|------|-------------|--------------|-------------|------|
| **基本機能** | `tests/basic/test_*.py` | `tests/basic/*.test.js` | `tests/basic/*.rs` | 基本動作テスト |
| **コア機能・単体テスト** | `tests/core/test_*.py` | `tests/core/*.test.js` | `tests/core/*.rs` | コア機能・単体テスト |
| **CLI機能** | `tests/cli/test_*.py` | `tests/cli/*.test.js` | `tests/cli/*.rs` | コマンドライン機能テスト |
| **エラー処理** | `tests/errors/test_*.py` | `tests/errors/*.test.js` | `tests/errors/*.rs` | エラーハンドリングテスト |
| **個別機能** | `tests/features/test_*.py` | `tests/features/*.test.js` | `tests/features/*.rs` | 固有機能テスト |
| **出力形式** | `tests/formats/test_*.py` | `tests/formats/*.test.js` | `tests/formats/*.rs` | 出力フォーマットテスト |
| **統合テスト** | `tests/integration/test_*.py` | `tests/integration/*.test.js` | `tests/integration/*.rs` | 複合機能テスト |
| **ドキュメント例** | `tests/docs_examples/test_*.py` | `tests/docs_examples/*.test.js` | `tests/docs_examples/*.rs` | ドキュメント例示テスト |

## 🚫 絶対禁止事項

### **テストファイルの無断削除禁止**
- 既存のテストファイルは**絶対に削除してはならない**
- 統一化作業でファイルが「失われる」ことは**事故**に相当
- 原則を知った以上、**二度と消してはならない**

### **不完全な調査に基づく修正禁止**
- 実際のファイル構造を**完全に調査**してから修正する
- 推測や不正確な情報に基づく変更を行わない
- 「失われた」「存在しない」と判断する前に、徹底的に確認する

## ✅ 統一化手順

### Phase 1: 現状調査
1. 各プロジェクトの現在のテストファイル状況を**完全**調査
2. npmの6ファイル構成を参考モデルとして確認
3. 既存のテスト内容を分析・分類

### Phase 2: ファイル作成・分配
1. 不足しているテストファイルを作成
2. 既存のテスト内容を適切なファイルに分配
3. 各ファイルで適切なテストケースを実装

### Phase 3: 検証
1. 全プロジェクトで6ファイル構成が完成していることを確認
2. テスト実行でエラーがないことを確認
3. 機能網羅率の向上を確認

## 📊 目標状態

### **lawkit パッケージ**
- **lawkit-python**: 8サブディレクトリ (`tests/basic/`, `tests/core/`, `tests/cli/`, `tests/errors/`, `tests/features/`, `tests/formats/`, `tests/integration/`, `tests/docs_examples/`) ✅サブフォルダ化完成済み
- **lawkit-js**: 8サブディレクトリ (`tests/basic/`, `tests/core/`, `tests/cli/`, `tests/errors/`, `tests/features/`, `tests/formats/`, `tests/integration/`, `tests/docs_examples/`) ✅サブフォルダ化完成済み

### **diffai パッケージ**
- **diffai-python**: 8サブディレクトリ (`tests/basic/`, `tests/core/`, `tests/cli/`, `tests/errors/`, `tests/features/`, `tests/formats/`, `tests/integration/`, `tests/docs_examples/`)
- **diffai-js**: 8サブディレクトリ (`tests/basic/`, `tests/core/`, `tests/cli/`, `tests/errors/`, `tests/features/`, `tests/formats/`, `tests/integration/`, `tests/docs_examples/`)

### **diffx パッケージ**
- **diffx-python**: 8サブディレクトリ (`tests/basic/`, `tests/core/`, `tests/cli/`, `tests/errors/`, `tests/features/`, `tests/formats/`, `tests/integration/`, `tests/docs_examples/`)
- **diffx-js**: 8サブディレクトリ (`tests/basic/`, `tests/core/`, `tests/cli/`, `tests/errors/`, `tests/features/`, `tests/formats/`, `tests/integration/`, `tests/docs_examples/`)

## 🔄 継続的遵守

この原則は**絶対に破ってはならない基本ルール**です：

1. **統一性の維持**: 全プロジェクトで同じテスト分類を維持
2. **完全性の確保**: 6ファイル構成を常に維持
3. **既存保護**: 既存のテストファイルを保護
4. **慎重な作業**: 調査不足による誤った変更を防止

このテスト組織化原則により、3プロジェクトの品質と保守性を確保します。