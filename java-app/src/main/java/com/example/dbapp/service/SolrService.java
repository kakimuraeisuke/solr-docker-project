package com.example.dbapp.service;

import com.example.dbapp.model.Product;
import com.example.dbapp.model.User;
import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.UpdateResponse;
import org.apache.solr.common.SolrInputDocument;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;
import java.util.Properties;

/**
 * Solrとの接続と操作を行うサービスクラス
 */
public class SolrService {
    private static final Logger logger = LoggerFactory.getLogger(SolrService.class);
    
    private final Properties config;
    private SolrClient solrClient;

    public SolrService(Properties config) {
        this.config = config;
        initializeSolrClient();
    }

    /**
     * Solrクライアントを初期化する
     */
    private void initializeSolrClient() {
        String solrUrl = config.getProperty("solr.url");
        solrClient = new HttpSolrClient.Builder(solrUrl).build();
        logger.info("Solrクライアントを初期化しました: {}", solrUrl);
    }

    /**
     * Solrクライアントを閉じる
     */
    public void close() {
        if (solrClient != null) {
            try {
                solrClient.close();
                logger.info("Solrクライアントを閉じました");
            } catch (IOException e) {
                logger.error("Solrクライアントのクローズに失敗しました", e);
            }
        }
    }

    /**
     * ユーザーをSolrにインデックスする
     * @param users ユーザーリスト
     */
    public void indexUsers(List<User> users) {
        try {
            for (User user : users) {
                SolrInputDocument doc = new SolrInputDocument();
                doc.addField("id", "user_" + user.getId());
                doc.addField("type", "user");
                doc.addField("username", user.getUsername());
                doc.addField("email", user.getEmail());
                doc.addField("first_name", user.getFirstName());
                doc.addField("last_name", user.getLastName());
                doc.addField("full_name", user.getFirstName() + " " + user.getLastName());
                doc.addField("created_at", user.getCreatedAt());
                
                solrClient.add(doc);
            }
            
            UpdateResponse response = solrClient.commit();
            logger.info("{}件のユーザーをSolrにインデックスしました", users.size());
            
        } catch (SolrServerException | IOException e) {
            logger.error("ユーザーのインデックスに失敗しました", e);
        }
    }

    /**
     * 商品をSolrにインデックスする
     * @param products 商品リスト
     */
    public void indexProducts(List<Product> products) {
        try {
            for (Product product : products) {
                SolrInputDocument doc = new SolrInputDocument();
                doc.addField("id", "product_" + product.getId());
                doc.addField("type", "product");
                doc.addField("name", product.getName());
                doc.addField("description", product.getDescription());
                doc.addField("price", product.getPrice().doubleValue());
                doc.addField("category", product.getCategory());
                doc.addField("stock_quantity", product.getStockQuantity());
                doc.addField("created_at", product.getCreatedAt());
                
                solrClient.add(doc);
            }
            
            UpdateResponse response = solrClient.commit();
            logger.info("{}件の商品をSolrにインデックスしました", products.size());
            
        } catch (SolrServerException | IOException e) {
            logger.error("商品のインデックスに失敗しました", e);
        }
    }

    /**
     * Solrのインデックスをクリアする
     */
    public void clearIndex() {
        try {
            solrClient.deleteByQuery("*:*");
            solrClient.commit();
            logger.info("Solrのインデックスをクリアしました");
        } catch (SolrServerException | IOException e) {
            logger.error("インデックスのクリアに失敗しました", e);
        }
    }
}
