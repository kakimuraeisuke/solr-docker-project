#!/bin/bash

echo "🔍 Solr文字化け修正のテストを開始します..."

# 既存のコンテナを停止・削除
echo "📦 既存のコンテナを停止・削除中..."
docker-compose down -v

# コンテナを起動
echo "🚀 コンテナを起動中..."
docker-compose up -d

# データベースの準備完了を待機
echo "⏳ データベースの準備完了を待機中..."
sleep 30

# Solrの準備完了を待機
echo "⏳ Solrの準備完了を待機中..."
sleep 20

# Javaアプリケーションを実行
echo "☕ Javaアプリケーションを実行中..."
cd java-app
mvn clean compile exec:java -Dexec.mainClass="com.example.dbapp.Main"
cd ..

echo "✅ テスト完了！"
echo "🌐 Solr管理画面: http://localhost:8983/solr"
echo "🔍 検索テスト: http://localhost:8983/solr/my_custom_core/select?q=ノートパソコン&wt=json"
