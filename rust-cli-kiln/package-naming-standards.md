# パッケージ命名規則統一標準

## 概要

Rust CLI ツール群（lawkit, diffx, diffai 等）の多言語対応における統一命名規則。
将来の拡張性とブランド統一性を保つための標準仕様。

## 統一命名規則

### 基本原則

1. **CLI名を基準とした統一**: 全言語で同じツール名を基軸とする
2. **衝突回避の徹底**: 将来の名前衝突を防ぐ安全性優先
3. **拡張性の確保**: 新しいCLIツール追加時の一貫性維持

### 言語別命名パターン

#### **Rust (CLI本体)**
```rust
// パッケージ名 = バイナリ名 = プロジェクト名
diffx, lawkit, diffai
```

#### **Python (PyPI)**
```bash
# インストール
pip install diffx-python
pip install lawkit-python  
pip install diffai-python

# インポート (重要: アンダースコア使用)
import diffx_python
import lawkit_python
import diffai_python
```

#### **Node.js (npm)**
```bash
# インストール
npm install diffx-js
npm install lawkit-js
npm install diffai-js

# インポート
const diffx = require('diffx-js')
const lawkit = require('lawkit-js')
const diffai = require('diffai-js')
```

## 命名の根拠

### Python: `_python` サフィックス採用理由

1. **衝突回避**: `diffx` 等の短い汎用名は将来の衝突リスクが高い
2. **ブランド統一**: 全CLIツールで一貫した命名パターン
3. **明確性**: 言語バインディングであることの明示

### Node.js: `-js` サフィックス採用理由

1. **npm慣習**: パッケージ名 = require名 の原則
2. **衝突回避**: 既存npmパッケージとの重複防止
3. **一貫性**: Python同様の言語識別子付与

## 実装例

### ディレクトリ構造
```
project-root/
├── diffx/              # Rust CLI本体
├── diffx-python/       # Pythonバインディング (src/diffx_python/)
├── diffx-js/           # Node.jsバインディング  
├── lawkit/
├── lawkit-python/      # (src/lawkit_python/)
├── lawkit-js/
└── ...
```

### パッケージ設定例

#### Python pyproject.toml
```toml
[project]
name = "diffx-python"     # PyPI上のパッケージ名

[tool.setuptools.packages.find]
where = ["src"]           # src/diffx_python/ を探す
```

#### Node.js package.json
```json
{
  "name": "diffx-js",     # npm上のパッケージ名
  "main": "index.js"
}
```

## 遵守必須事項

1. **新CLIツール作成時**: この命名規則に必ず従う
2. **既存ツール変更時**: 統一性を保つため全言語同時変更
3. **ドキュメント更新**: 命名変更時は全ドキュメントを同期更新

## 参考: 他ライブラリの命名例

### Python (パッケージ名 ≠ インポート名が一般的)
- `pip install scikit-learn` → `import sklearn`
- `pip install beautifulsoup4` → `import bs4`
- `pip install google-cloud-storage` → `import google.cloud.storage`

### Node.js (パッケージ名 = require名が一般的)
- `npm install express` → `require('express')`
- `npm install lodash` → `require('lodash')`

---

**策定日**: 2025-07-23  
**適用範囲**: 全Rust CLIツール及びその言語バインディング  
**更新責任**: Claude Code セッション記録