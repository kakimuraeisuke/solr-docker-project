#!/bin/bash

echo "Solrコアにデータを追加しています..."

# データの追加
curl -X POST -H 'Content-type:application/json' \
  'http://localhost:8983/solr/my_custom_core/update?commit=true' \
  --data-binary @sample_data.json

echo ""
echo "データの追加が完了しました！"
echo ""

# インデックスの状態を確認
echo "インデックスの状態を確認中..."
curl -s "http://localhost:8983/solr/my_custom_core/select?q=*:*&wt=json&rows=0" | python3 -m json.tool

echo ""
echo "検索テストを実行中..."
echo ""

# 簡単な検索テスト
echo "1. 'Solr' で検索:"
curl -s "http://localhost:8983/solr/my_custom_core/select?q=Solr&wt=json&indent=true" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(f'検索結果数: {data[\"response\"][\"numFound\"]}')
for doc in data['response']['docs']:
    print(f'- {doc[\"title\"]}')
"

echo ""
echo "2. 'Docker' で検索:"
curl -s "http://localhost:8983/solr/my_custom_core/select?q=Docker&wt=json&indent=true" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(f'検索結果数: {data[\"response\"][\"numFound\"]}')
for doc in data['response']['docs']:
    print(f'- {doc[\"title\"]}')
"

echo ""
echo "データの準備が完了しました！" 