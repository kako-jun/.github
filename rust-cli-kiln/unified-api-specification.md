# 統一API仕様書 - diffx, diffai, lawkit

## 概要

3プロジェクト（diffx, diffai, lawkit）のcore APIを統一し、一貫性のあるライブラリインターフェースを提供する。

## 設計原則

### 1. 単一関数設計
- **メイン関数は`diff()`のみ**
- 全ての機能差分はオプション引数で制御
- CLIオプション → API引数の直接マッピング

### 2. 言語別命名規則
- **Rust**: `snake_case`
- **Python**: `snake_case` (Rustと同じ)
- **JavaScript**: `camelCase`

### 3. オプション引数設計
- **Rust**: 構造体
- **Python**: `**kwargs` 
- **JavaScript**: options object

## 統一API仕様

### メイン関数

#### Rust (diffx/diffai)
```rust
pub fn diff(
    old: &serde_json::Value, 
    new: &serde_json::Value, 
    options: Option<&DiffOptions>
) -> Result<Vec<DiffResult>, Error>
```

#### Rust (lawkit) 
```rust
pub fn law(
    subcommand: &str,
    data_or_config: &serde_json::Value,
    options: Option<&LawkitOptions>
) -> Result<LawkitResult, Error>
```

#### Python (diffx/diffai)
```python
def diff(old: dict, new: dict, **options) -> List[Dict]:
    """Compare two JSON-like structures with optional parameters."""
```

#### Python (lawkit)
```python
def law(subcommand: str, data_or_config: Union[dict, list], **options) -> Dict:
    """Analyze data using statistical laws."""
```

#### JavaScript (diffx/diffai)
```javascript
function diff(old, new, options = {}) {
    // Compare two JSON structures with optional parameters
    return DiffResult[]
}
```

#### JavaScript (lawkit)
```javascript
function law(subcommand, dataOrConfig, options = {}) {
    // Analyze data using statistical laws
    return LawkitResult
}
```

### 共通オプション構造

#### Rust
```rust
#[derive(Debug, Clone, Default)]
pub struct DiffOptions {
    // 数値比較
    pub epsilon: Option<f64>,
    
    // 配列比較
    pub array_id_key: Option<String>,
    
    // フィルタリング
    pub ignore_keys_regex: Option<String>,
    pub path_filter: Option<String>,
    
    // 出力制御
    pub output_format: Option<OutputFormat>,
    pub show_unchanged: Option<bool>,
    pub show_types: Option<bool>,
    
    // メモリ最適化
    pub use_memory_optimization: Option<bool>,
    pub batch_size: Option<usize>,
    
    // 各プロジェクト特有オプション
    pub diffx_options: Option<DiffxSpecificOptions>,
    pub diffai_options: Option<DiffaiSpecificOptions>, 
    pub lawkit_options: Option<LawkitSpecificOptions>,
}
```

#### Python/JavaScript等価オプション
```python
# Python example
result = diff(old, new, 
    epsilon=0.001,
    array_id_key="id",
    ignore_keys_regex="^(timestamp|metadata)",
    output_format="json",
    show_unchanged=False
)
```

```javascript
// JavaScript example  
const result = diff(old, new, {
    epsilon: 0.001,
    arrayIdKey: "id",
    ignoreKeysRegex: "^(timestamp|metadata)",
    outputFormat: "json",
    showUnchanged: false
});
```

### 結果構造

#### Rust
```rust
#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum DiffResult {
    Added(String, serde_json::Value),
    Removed(String, serde_json::Value), 
    Modified(String, serde_json::Value, serde_json::Value),
    // プロジェクト特有の結果型
    TensorShapeChanged(String, Vec<usize>, Vec<usize>), // diffai
    LawViolation(String, f64, String), // lawkit
}
```

## 各プロジェクト特有オプション

### diffx特有オプション
```rust
#[derive(Debug, Clone, Default)]
pub struct DiffxSpecificOptions {
    pub context_lines: Option<usize>,
    pub ignore_whitespace: Option<bool>,
    pub ignore_case: Option<bool>,
    pub brief_mode: Option<bool>,
    pub quiet_mode: Option<bool>,
}
```

### diffai特有オプション  
```rust
#[derive(Debug, Clone, Default)]
pub struct DiffaiSpecificOptions {
    pub ml_analysis_enabled: Option<bool>,
    pub tensor_comparison_mode: Option<String>,
    pub model_format: Option<String>, // "pytorch", "safetensors", etc.
    pub scientific_precision: Option<bool>,
}
```

### lawkit特有オプション
```rust
#[derive(Debug, Clone, Default)]  
pub struct LawkitSpecificOptions {
    pub laws_to_check: Option<Vec<String>>, // ["benford", "pareto", etc.]
    pub analysis_threshold: Option<f64>,
    pub confidence_level: Option<f64>,
    pub statistical_tests: Option<Vec<String>>,
}
```

## 補助関数（統一）

### パース関数群
```rust
// 全プロジェクト共通
pub fn parse_json(content: &str) -> Result<serde_json::Value, Error>
pub fn parse_csv(content: &str) -> Result<serde_json::Value, Error> 
pub fn parse_xml(content: &str) -> Result<serde_json::Value, Error>
pub fn parse_ini(content: &str) -> Result<serde_json::Value, Error>
pub fn parse_yaml(content: &str) -> Result<serde_json::Value, Error>
pub fn parse_toml(content: &str) -> Result<serde_json::Value, Error>

// diffai特有
pub fn parse_pytorch_model(path: &Path) -> Result<serde_json::Value, Error>
pub fn parse_safetensors_model(path: &Path) -> Result<serde_json::Value, Error>
pub fn parse_numpy_file(path: &Path) -> Result<serde_json::Value, Error>
pub fn parse_matlab_file(path: &Path) -> Result<serde_json::Value, Error>
```

### ユーティリティ関数群
```rust
// 全プロジェクト共通
pub fn estimate_memory_usage(value: &serde_json::Value) -> usize
pub fn value_type_name(value: &serde_json::Value) -> &str
pub fn format_output<T: Serialize>(
    results: &[T], 
    format: OutputFormat
) -> Result<String, Error>
```

## 出力フォーマット統一

```rust
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum OutputFormat {
    // 共通フォーマット
    Json,
    Yaml, 
    Csv,
    
    // プロジェクト独自フォーマット
    Diffx,    // diffx独自
    Unified,  // diff-like unified format
    Text,     // lawkit text output
}
```

## CLIオプション → API引数マッピング

| CLIオプション | Rust構造体フィールド | Python引数 | JavaScript引数 |
|---------------|---------------------|-------------|----------------|
| `--epsilon 0.001` | `epsilon: Some(0.001)` | `epsilon=0.001` | `epsilon: 0.001` |
| `--array-id-key id` | `array_id_key: Some("id")` | `array_id_key="id"` | `arrayIdKey: "id"` |
| `--ignore-keys-regex "^meta"` | `ignore_keys_regex: Some("^meta")` | `ignore_keys_regex="^meta"` | `ignoreKeysRegex: "^meta"` |
| `--output json` | `output_format: Some(Json)` | `output_format="json"` | `outputFormat: "json"` |
| `--verbose` | `verbose: Some(true)` | `verbose=True` | `verbose: true` |
| `--no-color` | `no_color: Some(true)` | `no_color=True` | `noColor: true` |

## 実装計画

### フェーズ1: 仕様策定 ✅ 完了
- [x] 統一API仕様書作成
- [x] 各プロジェクトの現状分析
- [x] 移行計画策定

### フェーズ2: 実装リファクタリング ✅ 完了
- [x] diffx core関数統一 - 既存API完全削除、新API実装
- [x] diffai core関数統一 - 既存API完全削除、新API実装
- [x] lawkit core関数統一 - 既存API完全削除、新API実装

### フェーズ3: バインディング更新 ✅ 完了
- [x] Python bindings統一 - PyO3 0.22使用、全プロジェクト実装完了
- [x] JavaScript bindings統一 - NAPI-RS 2.2使用、全プロジェクト実装完了
- [x] CLIバイナリラッパー方式からネイティブバインディングへ完全移行

### フェーズ4: 検証・ドキュメント更新 🔄 進行中
- [ ] 統一後テスト実装・実行
- [x] パッケージ設定更新 (pyproject.toml, package.json)
- [x] ワークフロー更新 (PyO3/NAPIビルド方式へ)
- [ ] 使用例更新

## 完全書き直し方針

**既存API関数は完全削除** - 後方互換性は維持しない：

- 3つのプロジェクトは現在ユーザーが存在しないため、破壊的変更が可能
- 既存の古い関数群（`diff_basic`, `diff_standard`, `diff_optimized`等）は全て削除
- クリーンな統一APIのみを提供

## 実装結果サマリー (2025年7月)

### 削除された旧API
- **diffx**: `diff_standard()`, `diff_optimized()`, `diff_memory_efficient()` 等
- **diffai**: `diff_pytorch()`, `diff_safetensors()`, `diff_numpy()` 等の個別関数
- **lawkit**: 8000行以上の旧CLI実装コード（`src/subcommands/`, `src/main.rs`）

### 新統一API
- **diffx/diffai**: 単一の `diff()` 関数で全機能を提供
- **lawkit**: 単一の `law()` 関数でサブコマンドベースの機能を提供
- **バインディング**: PyO3 0.22とNAPI-RS 2.2による高性能なネイティブバインディング

### アーキテクチャ変更
- CLIバイナリラッパー方式 → ネイティブ言語バインディング
- バイナリダウンロード配布 → PyPI/NPMでのソースビルド配布
- 複雑な個別関数群 → シンプルな統一API

---

この仕様に基づいて3プロジェクトのAPIを統一し、一貫性のある多言語対応ライブラリを構築する。