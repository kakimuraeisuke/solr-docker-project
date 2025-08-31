#!/bin/bash

echo "🚀 Solr + MySQL + Java + SchemaSpy 統合プロジェクト クイックスタート"
echo "=================================================================="

# 色付きの出力関数
print_success() {
    echo -e "\033[32m✅ $1\033[0m"
}

print_info() {
    echo -e "\033[34mℹ️  $1\033[0m"
}

print_warning() {
    echo -e "\033[33m⚠️  $1\033[0m"
}

print_error() {
    echo -e "\033[31m❌ $1\033[0m"
}

# 前提条件のチェック
echo "📋 前提条件をチェック中..."

# Docker の確認
if ! command -v docker &> /dev/null; then
    print_error "Dockerがインストールされていません。Dockerをインストールしてください。"
    exit 1
fi

# Docker Compose の確認
if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Composeがインストールされていません。Docker Composeをインストールしてください。"
    exit 1
fi

# Java の確認
if ! command -v java &> /dev/null; then
    print_warning "Javaがインストールされていません。Java 11以上をインストールしてください。"
fi

# Maven の確認
if ! command -v mvn &> /dev/null; then
    print_warning "Mavenがインストールされていません。Maven 3.6以上をインストールしてください。"
fi

print_success "前提条件のチェックが完了しました"

# サービスの起動
echo ""
echo "🐳 Dockerサービスを起動中..."
docker-compose up -d

if [ $? -eq 0 ]; then
    print_success "Dockerサービスが起動しました"
else
    print_error "Dockerサービスの起動に失敗しました"
    exit 1
fi

# サービスの起動待機
echo ""
echo "⏳ サービスの起動を待機中..."
sleep 30

# サービスの状態確認
echo ""
echo "📊 サービスの状態を確認中..."
docker-compose ps

# MySQLの接続確認
echo ""
echo "🗄️  MySQLの接続を確認中..."
if docker exec my-mysql mysql -u user -ppassword -e "USE sampledb; SELECT COUNT(*) FROM users;" &> /dev/null; then
    print_success "MySQLに正常に接続できました"
else
    print_warning "MySQLの接続確認に失敗しました。しばらく待ってから再試行してください。"
fi

# Solrの接続確認
echo ""
echo "🔍 Solrの接続を確認中..."
if curl -s http://localhost:8983/solr/ &> /dev/null; then
    print_success "Solrに正常に接続できました"
else
    print_warning "Solrの接続確認に失敗しました。しばらく待ってから再試行してください。"
fi

echo ""
echo "🎉 セットアップが完了しました！"
echo ""
echo "📖 次のステップ:"
echo "1. Javaアプリケーションの実行: ./run_app.sh"
echo "2. SchemaSpyによるドキュメント生成: ./run_schemaspy.sh"
echo ""
echo "🌐 アクセス可能なサービス:"
echo "- Solr管理画面: http://localhost:8983/solr"
echo "- MySQL: localhost:3306"
echo "- SchemaSpy: http://localhost:8080"
echo ""
echo "📚 詳細な使用方法は README.md を参照してください。"
