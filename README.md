# Solr Docker プロジェクト

このプロジェクトは、Docker Composeを使用してSolrコアを作成し、起動するための設定です。

## 前提条件

- Docker
- Docker Compose

## 使用方法

### 1. Solrコアの起動

```bash
docker-compose up -d
```

### 2. アクセス

Solr管理画面にアクセスするには、ブラウザで以下のURLを開いてください：
- http://localhost:8983/solr/

### 3. コアの確認

管理画面の左側のメニューで「my_custom_core」コアが表示されていることを確認してください。

### 4. 停止

```bash
docker-compose down
```

### 5. データの永続化

データは`solr_data`ボリュームに保存され、コンテナを停止しても保持されます。

## プロジェクト構造

```
solr_docker_project/
├── docker-compose.yml          # Docker Compose設定
├── my_custom_core/            # カスタムコア設定
│   └── conf/                  # コア設定ファイル
│       ├── managed-schema     # スキーマ定義
│       └── solrconfig.xml     # Solr設定
└── README.md                  # このファイル
```

## カスタマイズ

- `my_custom_core/conf/managed-schema`: フィールド定義やフィールドタイプを変更
- `my_custom_core/conf/solrconfig.xml`: Solrの動作設定を変更
- `docker-compose.yml`: ポート番号やメモリ設定を変更

## トラブルシューティング

### ポートが既に使用されている場合
`docker-compose.yml`の`ports`セクションでポート番号を変更してください。

### メモリ不足の場合
`docker-compose.yml`の`SOLR_HEAP`環境変数を調整してください。 