#!/bin/bash

echo "=== SchemaSpy データベースドキュメント生成スクリプト ==="

# 出力ディレクトリを作成
mkdir -p schemaspy_output

# SchemaSpyを実行してデータベースドキュメントを生成
echo "SchemaSpyでデータベースドキュメントを生成中..."

docker run --rm \
  --network solr_docker_project_default \
  -v "$(pwd)/schemaspy_output:/output" \
  tlvu/schemaspy \
  java -jar /home/user/pkg/schemaSpy.jar \
  -t mysql \
  -host mysql \
  -port 3306 \
  -db sampledb \
  -u user \
  -p password \
  -o /output

if [ $? -eq 0 ]; then
    echo "SchemaSpyが正常に完了しました！"
    echo "出力ディレクトリ: ./schemaspy_output"
    echo "HTMLファイル: ./schemaspy_output/index.html"
    
    # ブラウザで開く（macOS）
    if command -v open >/dev/null 2>&1; then
        echo "ブラウザでドキュメントを開いています..."
        open ./schemaspy_output/index.html
    fi
else
    echo "SchemaSpyの実行に失敗しました。"
    exit 1
fi
