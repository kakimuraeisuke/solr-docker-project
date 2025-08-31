#!/bin/bash

echo "=== Java データベースアプリケーション実行スクリプト ==="

# Javaアプリケーションディレクトリに移動
cd java-app

# Mavenでプロジェクトをビルド
echo "Mavenでプロジェクトをビルド中..."
mvn clean package

if [ $? -eq 0 ]; then
    echo "ビルドが成功しました！"
    
    # アプリケーションを実行
    echo "アプリケーションを実行中..."
    java -jar target/dbapp-1.0.0.jar
    
else
    echo "ビルドに失敗しました。"
    exit 1
fi
