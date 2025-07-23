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

#### Rust
```rust
pub fn diff(
    old: &serde_json::Value, 
    new: &serde_json::Value, 
    options: Option<&DiffOptions>
) -> Result<Vec<DiffResult>, Error>
```

#### Python
```python
def diff(old: dict, new: dict, **options) -> List[Dict]:
    """Compare two JSON-like structures with optional parameters."""
```

#### JavaScript
```javascript
function diff(old, new, options = {}) {
    // Compare two JSON structures with optional parameters
    return Promise<DiffResult[]>
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

### フェーズ1: 仕様策定
- [x] 統一API仕様書作成
- [ ] 各プロジェクトの現状分析
- [ ] 移行計画策定

### フェーズ2: 実装リファクタリング
- [ ] diffx core関数統一
- [ ] diffai core関数統一  
- [ ] lawkit core関数統一

### フェーズ3: バインディング更新
- [ ] Python bindings統一
- [ ] JavaScript bindings統一
- [ ] テスト更新

### フェーズ4: 検証・ドキュメント更新
- [ ] 統一後テスト実行
- [ ] ドキュメント更新
- [ ] 使用例更新

## 後方互換性

既存API関数は**エイリアス**として残す：

```rust
// 移行期間中の後方互換性
#[deprecated(since = "3.0.0", note = "Use diff() instead")]
pub fn diff_basic(v1: &Value, v2: &Value) -> Vec<DiffResult> {
    diff(v1, v2, None).unwrap_or_default()
}

#[deprecated(since = "3.0.0", note = "Use diff() with options instead")]
pub fn diff_arrays_with_id_enhanced(/*...*/) -> Vec<DiffResult> {
    let options = DiffOptions {
        array_id_key: Some(id_key.to_string()),
        ..Default::default()
    };
    diff(old, new, Some(&options)).unwrap_or_default()
}
```

---

この仕様に基づいて3プロジェクトのAPIを統一し、一貫性のある多言語対応ライブラリを構築する。