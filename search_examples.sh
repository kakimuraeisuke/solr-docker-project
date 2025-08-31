#!/bin/bash

echo "=== Solr 検索例 ==="
echo ""

# 1. 全件検索
echo "1. 全件検索 (*:*)"
curl -s "http://localhost:8983/solr/my_custom_core/select?q=*:*&wt=json&rows=5" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(f'総件数: {data[\"response\"][\"numFound\"]}')
for doc in data['response']['docs']:
    print(f'- {doc[\"title\"]} (ID: {doc[\"id\"]})')
"
echo ""

# 2. タイトルフィールドでの検索
echo "2. タイトルフィールドで '検索' を含むドキュメント"
curl -s "http://localhost:8983/solr/my_custom_core/select?q=title:検索&wt=json&indent=true" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(f'検索結果数: {data[\"response\"][\"numFound\"]}')
for doc in data['response']['docs']:
    print(f'- {doc[\"title\"]}')
    print(f'  内容: {doc[\"content\"][:50]}...')
"
echo ""

# 3. 内容フィールドでの検索
echo "3. 内容フィールドで 'Docker' を含むドキュメント"
curl -s "http://localhost:8983/solr/my_custom_core/select?q=content:Docker&wt=json&indent=true" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(f'検索結果数: {data[\"response\"][\"numFound\"]}')
for doc in data['response']['docs']:
    print(f'- {doc[\"title\"]}')
"
echo ""

# 4. 複数フィールドでの検索
echo "4. タイトルまたは内容で 'Solr' を含むドキュメント"
curl -s "http://localhost:8983/solr/my_custom_core/select?q=title:Solr%20OR%20content:Solr&wt=json&indent=true" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(f'検索結果数: {data[\"response\"][\"numFound\"]}')
for doc in data['response']['docs']:
    print(f'- {doc[\"title\"]}')
"
echo ""

# 5. フィルタリング（特定の日時以降）
echo "5. 2025-08-31T11:00:00Z 以降のドキュメント"
curl -s "http://localhost:8983/solr/my_custom_core/select?q=*:*&fq=timestamp:[2025-08-31T11:00:00Z%20TO%20*]&wt=json&indent=true" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(f'検索結果数: {data[\"response\"][\"numFound\"]}')
for doc in data['response']['docs']:
    print(f'- {doc[\"title\"]} (作成日時: {doc[\"timestamp\"]})')
"
echo ""

# 6. ソート（タイトル順）
echo "6. タイトル順でソート"
curl -s "http://localhost:8983/solr/my_custom_core/select?q=*:*&sort=title%20asc&wt=json&indent=true" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(f'検索結果数: {data[\"response\"][\"numFound\"]}')
for doc in data['response']['docs']:
    print(f'- {doc[\"title\"]}')
"
echo ""

echo "=== 検索例完了 ===" 