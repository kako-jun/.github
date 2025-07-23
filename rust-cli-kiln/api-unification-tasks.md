# API統一リファクタリング タスクリスト

## 概要

diffx, diffai, lawkit の3プロジェクトのAPI統一を目的としたリファクタリング計画。
統一API仕様書（`unified-api-specification.md`）に基づく実装作業。

## 前提条件

**重要**: このリファクタリングは全プロジェクトのクイックチェック完了後に実施する。

## タスク一覧

### Phase 1: 準備・現状分析

- [x] **1.1 統一API仕様書作成**
  - [x] unified-api-specification.md 作成完了
  - [x] 関数設計原則確定（単一diff()関数 + オプション引数）
  - [x] 言語別命名規則確定（Rust: snake_case, Python: snake_case, JS: camelCase）

- [ ] **1.2 現状API分析**
  - [ ] diffx-core: 現在の公開関数リスト作成
  - [ ] diffai-core: 現在の公開関数リスト作成  
  - [ ] lawkit-core: 現在の公開関数リスト作成
  - [ ] 各プロジェクトの関数シグネチャ比較表作成

- [ ] **1.3 移行計画詳細化**
  - [ ] 後方互換性維持戦略確定（deprecated aliasesの期間設定）
  - [ ] テスト更新計画作成
  - [ ] ドキュメント更新計画作成

### Phase 2: 実装リファクタリング

#### 2.1 diffx統一リファクタリング

- [ ] **2.1.1 DiffOptions構造体実装**
  ```rust
  // 新しい統一DiffOptions構造体を実装
  pub struct DiffOptions {
      pub epsilon: Option<f64>,
      pub array_id_key: Option<String>,
      pub ignore_keys_regex: Option<String>,
      // ... 他のオプション
      pub diffx_options: Option<DiffxSpecificOptions>,
  }
  ```

- [ ] **2.1.2 統一diff()関数実装**
  ```rust
  pub fn diff(
      old: &serde_json::Value,
      new: &serde_json::Value, 
      options: Option<&DiffOptions>
  ) -> Result<Vec<DiffResult>, Error>
  ```

- [ ] **2.1.3 既存関数を後方互換エイリアス化**
  ```rust
  #[deprecated(since = "3.0.0", note = "Use diff() instead")]
  pub fn diff_standard(...) -> Vec<DiffResult> {
      // diff()へのラッパー実装
  }
  ```

- [ ] **2.1.4 diffx-cli更新**
  - [ ] CLI引数 → DiffOptions への変換ロジック実装
  - [ ] main.rs の統一API呼び出し更新

#### 2.2 diffai統一リファクタリング

- [ ] **2.2.1 DiffOptions構造体実装（diffai版）**
  - [ ] diffai固有オプション統合
  - [ ] ML分析オプションの統合

- [ ] **2.2.2 統一diff()関数実装**
  - [ ] 既存diff_basic()の機能を統合
  - [ ] ML分析機能の統合

- [ ] **2.2.3 既存関数を後方互換エイリアス化**
  ```rust
  #[deprecated(since = "3.0.0", note = "Use diff() instead")]
  pub fn diff_basic(...) -> Vec<DiffResult> {
      diff(v1, v2, None).unwrap_or_default()
  }
  ```

- [ ] **2.2.4 diffai-cli更新**
  - [ ] CLI引数 → DiffOptions への変換ロジック実装

#### 2.3 lawkit統一リファクタリング

- [ ] **2.3.1 lawkit用DiffOptions実装**
  - [ ] 各法則固有オプションの統合
  - [ ] 統計分析オプションの統合

- [ ] **2.3.2 統一diff()関数実装**
  - [ ] 各法則のanalyze()機能を統合
  - [ ] 法則選択ロジックの統合

- [ ] **2.3.3 既存analyze()関数群を後方互換エイリアス化**
  ```rust
  #[deprecated(since = "3.0.0", note = "Use diff() with lawkit_options instead")]
  pub fn analyze_benford(...) -> Result<BenfordResult, Error> {
      // diff()へのラッパー実装
  }
  ```

- [ ] **2.3.4 lawkit-cli更新**
  - [ ] サブコマンド → 統一diff()呼び出しへの変換

### Phase 3: バインディング統一

#### 3.1 Python バインディング更新

- [ ] **3.1.1 統一Python API実装**
  ```python
  def diff(old: dict, new: dict, **options) -> List[Dict]:
      """Unified diff function for all projects"""
  ```

- [ ] **3.1.2 各プロジェクトPythonパッケージ更新**
  - [ ] diffx-python: 統一API対応
  - [ ] diffai-python: 統一API対応
  - [ ] lawkit-python: 統一API対応

- [ ] **3.1.3 後方互換性維持**
  - [ ] 既存Python関数をdeprecated wrapper化

#### 3.2 JavaScript バインディング更新

- [ ] **3.2.1 統一JavaScript API実装**
  ```javascript
  function diff(old, new, options = {}) {
      // camelCase options への変換
      return diffUnified(old, new, convertOptions(options));
  }
  ```

- [ ] **3.2.2 各プロジェクトJSパッケージ更新**
  - [ ] diffx-js: 統一API対応
  - [ ] diffai-js: 統一API対応
  - [ ] lawkit-js: 統一API対応

### Phase 4: テスト統一・検証

#### 4.1 テストコード更新

- [ ] **4.1.1 統一APIテスト作成**
  - [ ] 各プロジェクト用統一API基本テスト
  - [ ] オプション組み合わせテスト
  - [ ] エラーハンドリングテスト

- [ ] **4.1.2 後方互換性テスト**
  - [ ] 既存deprecated関数の動作テスト
  - [ ] エイリアス関数の正常動作確認

- [ ] **4.1.3 クロスプロジェクトテスト**
  - [ ] 同じ入力に対する3プロジェクトの結果一貫性テスト
  - [ ] パフォーマンス比較テスト

#### 4.2 統合テスト実行

- [ ] **4.2.1 全プロジェクトテスト実行**
  - [ ] diffx: 統一API版テスト完全パス
  - [ ] diffai: 統一API版テスト完全パス
  - [ ] lawkit: 統一API版テスト完全パス

- [ ] **4.2.2 バインディングテスト実行**
  - [ ] Python: 統一API動作確認
  - [ ] JavaScript: 統一API動作確認

### Phase 5: ドキュメント・リリース

#### 5.1 ドキュメント更新

- [ ] **5.1.1 API仕様書更新**
  - [ ] 各プロジェクトdocs内にunified-api-reference.md追加
  - [ ] 移行ガイド作成

- [ ] **5.1.2 使用例更新**
  - [ ] README更新
  - [ ] docs内の例示コード統一API版に更新

#### 5.2 リリース準備

- [ ] **5.2.1 バージョニング**
  - [ ] メジャーバージョンアップ（v3.0.0）
  - [ ] CHANGELOG.md更新

- [ ] **5.2.2 最終検証**
  - [ ] 全機能回帰テスト
  - [ ] パフォーマンス劣化チェック
  - [ ] ドキュメント整合性チェック

## 実施順序

1. **Phase 1完了後** → Phase 2開始
2. **Phase 2完了後** → Phase 3開始  
3. **Phase 3完了後** → Phase 4開始
4. **Phase 4全テスト成功後** → Phase 5開始

## 重要な注意事項

### リファクタリング前の必須条件
- [ ] diffx クイックチェック完全成功
- [ ] diffai クイックチェック完全成功（core機能のみ）
- [ ] lawkit クイックチェック完全成功

### 実装時の原則
1. **テストファースト**: 新しいAPIのテストを先に作成
2. **段階的移行**: エイリアス → 統一API → エイリアス削除
3. **後方互換性**: 少なくとも1つのメジャーバージョン期間は保持
4. **コミット戦略**: 各プロジェクト別、機能別の細かいコミット

### 検証基準
- [ ] 既存機能の動作が完全に保持されること
- [ ] 新しいAPIで既存の全ユースケースが表現できること
- [ ] パフォーマンスが劣化しないこと
- [ ] メモリ使用量の有意な増加がないこと

## 成功基準

### 技術的成功基準
- [ ] 3プロジェクトで同一のdiff()関数シグネチャ
- [ ] オプション指定方法の完全統一
- [ ] Python/JSでの同等API提供
- [ ] 全既存テストの継続成功

### ユーザビリティ成功基準  
- [ ] CLI使用方法の直感的一貫性
- [ ] ライブラリ使用時の一貫した体験
- [ ] 言語間での学習コストの最小化

---

**最終目標**: diffx, diffai, lawkit を使用する際、どのプロジェクトでも同じ方法でAPIを呼び出せる統一された体験の提供