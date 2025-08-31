package com.example.dbapp;

import com.example.dbapp.service.DatabaseService;
import com.example.dbapp.service.SolrService;
import com.example.dbapp.util.ConfigLoader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Properties;

/**
 * メインアプリケーションクラス
 * MySQLとSolrを連携するデータベースアプリケーション
 */
public class Main {
    private static final Logger logger = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) {
        try {
            logger.info("データベースアプリケーションを開始します...");
            
            // 設定ファイルの読み込み
            Properties config = ConfigLoader.loadConfig();
            
            // データベースサービスの初期化
            DatabaseService dbService = new DatabaseService(config);
            
            // Solrサービスの初期化
            SolrService solrService = new SolrService(config);
            
            // データベースからデータを取得してSolrに投入
            logger.info("データベースからデータを取得中...");
            dbService.syncDataToSolr(solrService);
            
            logger.info("データベースアプリケーションが正常に完了しました。");
            
        } catch (Exception e) {
            logger.error("アプリケーションでエラーが発生しました: ", e);
            System.exit(1);
        }
    }
}
