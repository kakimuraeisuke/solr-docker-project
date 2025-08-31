# Solr データ管理ガイド

このドキュメントでは、Solrコアへのデータ追加と検索の実行方法について説明します。

## ファイル構成

```
solr_docker_project/
├── sample_data.json      # サンプルデータ（5件のドキュメント）
├── add_data.sh           # データ追加スクリプト
├── search_examples.sh    # 検索例スクリプト
└── DATA_README.md        # このファイル
```

## 1. データの追加

### サンプルデータの内容

`sample_data.json`には以下の5件のドキュメントが含まれています：

1. **Apache Solr 入門** - Solrの基本概念
2. **Docker での Solr 運用** - Docker環境での運用
3. **全文検索の基本概念** - 検索エンジンの仕組み
4. **Solr スキーマ設計** - スキーマ設計の重要性
5. **検索クエリの最適化** - クエリ最適化の方法

### データの追加方法

```bash
# スクリプトを実行してデータを追加
./add_data.sh
```

このスクリプトは以下を実行します：
- サンプルデータをSolrコアに追加
- インデックスの状態を確認
- 基本的な検索テストを実行

## 2. 検索の実行

### 基本的な検索例

```bash
# 様々な検索例を実行
./search_examples.sh
```

### 手動での検索実行

#### 全件検索
```bash
curl "http://localhost:8983/solr/my_custom_core/select?q=*:*&wt=json"
```

#### 特定の単語で検索
```bash
# タイトルで検索
curl "http://localhost:8983/solr/my_custom_core/select?q=title:Solr&wt=json"

# 内容で検索
curl "http://localhost:8983/solr/my_custom_core/select?q=content:Docker&wt=json"
```

#### 複数フィールドでの検索
```bash
# タイトルまたは内容で検索
curl "http://localhost:8983/solr/my_custom_core/select?q=title:検索%20OR%20content:検索&wt=json"
```

#### フィルタリング
```bash
# 特定の日時以降のドキュメント
curl "http://localhost:8983/solr/my_custom_core/select?q=*:*&fq=timestamp:[2025-08-31T11:00:00Z%20TO%20*]&wt=json"
```

#### ソート
```bash
# タイトル順でソート
curl "http://localhost:8983/solr/my_custom_core/select?q=*:*&sort=title%20asc&wt=json"
```

## 3. データの管理

### ドキュメントの削除

```bash
# 特定のドキュメントを削除
curl -X POST -H 'Content-type:application/json' \
  'http://localhost:8983/solr/my_custom_core/update?commit=true' \
  --data-binary '{"delete":{"id":"doc1"}}'

# 全件削除
curl -X POST -H 'Content-type:application/json' \
  'http://localhost:8983/solr/my_custom_core/update?commit=true' \
  --data-binary '{"delete":{"query":"*:*"}}'
```

### インデックスの最適化

```bash
# インデックスの最適化
curl "http://localhost:8983/solr/my_custom_core/update?optimize=true"
```

## 4. スキーマの確認

### フィールド定義の確認

```bash
curl "http://localhost:8983/solr/my_custom_core/schema/fields?wt=json"
```

### フィールドタイプの確認

```bash
curl "http://localhost:8983/solr/my_custom_core/schema/fieldtypes?wt=json"
```

## 5. トラブルシューティング

### よくある問題

1. **データが追加されない**
   - Solrコアが起動しているか確認
   - JSONの形式が正しいか確認

2. **検索結果が返ってこない**
   - インデックスが正しく作成されているか確認
   - コミットが実行されているか確認

3. **エラーが発生する**
   - ログを確認してエラーの詳細を把握
   - スキーマ設定が正しいか確認

### ログの確認

```bash
# コンテナのログを確認
docker-compose logs -f solr
```

## 6. 次のステップ

データの準備が完了したら、以下のことができます：

1. **カスタムデータの追加** - 独自のドキュメントを追加
2. **スキーマの拡張** - 新しいフィールドやフィールドタイプを追加
3. **検索機能の強化** - ファセット検索、ハイライト機能などを追加
4. **アプリケーションとの連携** - プログラムからSolrにアクセス

何かご質問がございましたら、お気軽にお申し付けください！ 