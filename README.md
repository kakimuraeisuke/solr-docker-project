# Solr + MySQL + Java + SchemaSpy 統合プロジェクト

このプロジェクトは、Apache Solr、MySQL、Java、SchemaSpyを統合した包括的なデータ管理・検索システムです。

## 🚀 機能

- **Apache Solr**: 高性能な全文検索エンジン
- **MySQL**: リレーショナルデータベース
- **Java**: データ処理とSolr連携アプリケーション
- **SchemaSpy**: データベーススキーマの自動ドキュメント生成

## 📋 前提条件

- Docker と Docker Compose
- Java 11以上
- Maven 3.6以上

## 🏗️ プロジェクト構造

```
solr_docker_project/
├── docker-compose.yml          # Dockerサービス設定
├── java-app/                   # Javaアプリケーション
│   ├── src/main/java/         # Javaソースコード
│   ├── src/main/resources/    # 設定ファイル
│   └── pom.xml               # Maven設定
├── mysql/                     # MySQL関連ファイル
│   ├── init/                 # 初期化SQLスクリプト
│   └── drivers/              # JDBCドライバー
├── my_custom_core/           # Solrカスタムコア設定
├── schemaspy_output/         # SchemaSpy出力ディレクトリ
├── run_app.sh                # Javaアプリ実行スクリプト
├── run_schemaspy.sh          # SchemaSpy実行スクリプト
└── README.md                 # このファイル
```

## 🚀 セットアップと実行

### 1. サービスの起動

```bash
# Docker Composeでサービスを起動
docker-compose up -d

# サービスの状態確認
docker-compose ps
```

### 2. データベースの初期化

MySQLコンテナが起動すると、自動的に以下の処理が実行されます：
- `sampledb`データベースの作成
- サンプルテーブルの作成（users, products, orders, order_items）
- サンプルデータの挿入

### 3. Javaアプリケーションの実行

```bash
# Javaアプリケーションをビルドして実行
./run_app.sh
```

このアプリケーションは：
- MySQLからデータを取得
- Solrにデータをインデックス
- ログファイルに処理結果を記録

### 4. SchemaSpyによるドキュメント生成

```bash
# データベーススキーマのドキュメントを生成
./run_schemaspy.sh
```

生成されるドキュメント：
- テーブル構造の詳細
- リレーションシップ図
- インデックス情報
- HTML形式で出力

## 🌐 アクセス情報

| サービス | URL | ポート | 説明 |
|---------|-----|--------|------|
| Solr Admin | http://localhost:8983/solr | 8983 | Solr管理画面 |
| MySQL | localhost | 3306 | データベース接続 |
| SchemaSpy | http://localhost:8080 | 8080 | ドキュメント表示 |

## 📊 データベーススキーマ

### テーブル構造

#### users
- `id`: 主キー
- `username`: ユーザー名（ユニーク）
- `email`: メールアドレス（ユニーク）
- `first_name`: 名
- `last_name`: 姓
- `created_at`: 作成日時
- `updated_at`: 更新日時

#### products
- `id`: 主キー
- `name`: 商品名
- `description`: 商品説明
- `price`: 価格
- `category`: カテゴリ
- `stock_quantity`: 在庫数
- `created_at`: 作成日時

#### orders
- `id`: 主キー
- `user_id`: ユーザーID（外部キー）
- `order_date`: 注文日
- `total_amount`: 合計金額
- `status`: 注文ステータス

#### order_items
- `id`: 主キー
- `order_id`: 注文ID（外部キー）
- `product_id`: 商品ID（外部キー）
- `quantity`: 数量
- `unit_price`: 単価

## 🔧 設定

### データベース接続設定
`java-app/src/main/resources/database.properties`で設定を変更できます。

### Solr設定
`my_custom_core/conf/`ディレクトリでSolrの設定をカスタマイズできます。

## 📝 ログ

アプリケーションのログは以下の場所に出力されます：
- コンソール出力
- `java-app/logs/dbapp.log`

## 🧪 テスト

```bash
# Mavenでテストを実行
cd java-app
mvn test
```

## 🐛 トラブルシューティング

### よくある問題

1. **ポート競合**
   - 既存のサービスが同じポートを使用している場合、`docker-compose.yml`でポート番号を変更

2. **データベース接続エラー**
   - MySQLコンテナが完全に起動するまで待機
   - 接続情報を確認

3. **Solr接続エラー**
   - Solrコアが正しく作成されているか確認
   - ネットワーク設定を確認

### ログの確認

```bash
# 各サービスのログを確認
docker-compose logs solr
docker-compose logs mysql
docker-compose logs schemaspy
```

## 📚 参考資料

- [Apache Solr Documentation](https://solr.apache.org/guide/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [SchemaSpy Documentation](https://schemaspy.readthedocs.io/)
- [Apache SolrJ](https://solr.apache.org/guide/solr/latest/developing-applications/solrj.html)

## 🤝 貢献

プロジェクトへの貢献を歓迎します。IssueやPull Requestをお気軽にお送りください。

## 📄 ライセンス

このプロジェクトはMITライセンスの下で公開されています。 