# 🗑️ Recursive Option Removal & Auto-Directory Detection Specification

**作成日**: 2025-07-24  
**対象**: diffx, diffai プロジェクト  

## 🎯 新仕様概要

### 基本方針
- **ユーザビリティ優先**: ディレクトリを渡したら自動的に再帰比較
- **直感的動作**: オプション指定不要でディレクトリ処理
- **現代的設計**: 1970年代のUNIX制約からの脱却

### 動作仕様
```bash
# ディレクトリ同士 → 自動的に再帰比較
diffx config1/ config2/     # 全ファイルを再帰的に比較
diffai model1/ model2/      # 全ファイルを再帰的に比較

# ファイル同士 → 通常比較（変更なし）
diffx file1.json file2.json

# ファイル vs ディレクトリ → 明確なエラー
diffx file.json config/     # Error: Cannot compare file with directory
```

## 🗑️ 削除対象

### CLI レベル
- `diffx --recursive` オプション削除
- `diffai --recursive` オプション削除

### Python API レベル  
- `diffx_python.DiffOptions.recursive: bool` フィールド削除
- `DiffOptions.to_args()` メソッドの `--recursive` 処理削除

### Core API レベル（追加実装）
- ディレクトリ自動判定機能追加
- 再帰的ファイル列挙機能追加

## 📊 影響範囲

| プロジェクト | 影響コンポーネント | 作業内容 |
|-------------|------------------|----------|
| **diffx** | CLI, Core, Python | 全面的修正 |
| **diffai** | CLI, Core | CLI/Core修正 |
| **lawkit** | なし | 変更なし |

## 🔍 詳細実装計画

### Step 2: diffx-core
```rust
// 新しいmain diff関数の動作
pub fn diff(input1: &str, input2: &str, options: Option<&DiffOptions>) -> Result<Vec<DiffResult>> {
    let path1 = Path::new(input1);
    let path2 = Path::new(input2);
    
    match (path1.is_dir(), path2.is_dir()) {
        (true, true) => diff_directories(path1, path2, options),
        (false, false) => diff_files(path1, path2, options), 
        _ => Err("Cannot compare file with directory"),
    }
}
```

### Step 3: diffx-cli  
```rust
// Args構造体から削除
// recursive: bool, ← 削除

// main関数での処理
fn main() -> Result<()> {
    let args = Args::parse();
    
    // 直接パスを渡す（ファイル・ディレクトリ自動判定）
    let results = diff(
        &args.input1.to_string_lossy(),
        &args.input2.to_string_lossy(), 
        Some(&options)
    )?;
}
```

### Step 4: diffx-python
```python
@dataclass 
class DiffOptions:
    """Configuration options for diffx comparison."""
    
    # recursive: bool = False  ← 削除
    path: Optional[str] = None
    # ... other options

    def to_args(self) -> List[str]:
        args = []
        # if self.recursive:  ← 削除
        #     args.append("--recursive")
        # ... other processing
```

## 🚨 Breaking Changes

### Python API
```python
# OLD (削除される)
diffx.diff('dir1/', 'dir2/', DiffOptions(recursive=True))

# NEW (自動的)  
diffx.diff('dir1/', 'dir2/')  # 自動的に再帰処理
```

### CLI
```bash
# OLD (削除される)
diffx --recursive dir1/ dir2/

# NEW (自動的)
diffx dir1/ dir2/  # 自動的に再帰処理
```

## ✅ 実装完了条件

1. ✅ 仕様明確化完了
2. ✅ diffx-core: ディレクトリ処理機能動作
3. ✅ diffx-cli: --recursive削除、自動判定動作  
4. ✅ diffx-python: recursive削除、自動動作
5. ✅ diffai-core: ディレクトリ処理機能動作
6. ✅ diffai-cli: --recursive削除、自動判定動作
7. 🔄 ドキュメント更新: 主要README完了（52ファイル中2ファイル更新済み）
8. ⏳ テスト全成功

## 📋 残りドキュメント更新作業

**更新対象**: 50ファイル（diffx: 19ファイル、diffai: 31ファイル）

**更新パターン**:
- `--recursive` → 削除または「自動ディレクトリ検出」説明に変更
- `recursive=True` → パラメータ削除
- 使用例の修正

**優先順位**:
1. ✅ README.md (完了)
2. CLI reference documentation
3. User guides  
4. Examples and tutorials
5. API documentation

---

**次のアクション**: Step 2 - diffx-core にディレクトリ処理機能追加