package com.example.dbapp.service;

import com.example.dbapp.model.Product;
import com.example.dbapp.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

/**
 * MySQLデータベースとの接続と操作を行うサービスクラス
 */
public class DatabaseService {
    private static final Logger logger = LoggerFactory.getLogger(DatabaseService.class);
    
    private final Properties config;
    private Connection connection;

    public DatabaseService(Properties config) {
        this.config = config;
    }

    /**
     * データベースに接続する
     * @throws SQLException 接続エラー
     */
    public void connect() throws SQLException {
        try {
            Class.forName(config.getProperty("mysql.driver"));
            connection = DriverManager.getConnection(
                config.getProperty("mysql.url"),
                config.getProperty("mysql.username"),
                config.getProperty("mysql.password")
            );
            
            // 文字エンコーディング設定（権限が必要な設定は除外）
            connection.setAutoCommit(true);
            try (Statement stmt = connection.createStatement()) {
                stmt.execute("SET NAMES utf8mb4");
                stmt.execute("SET CHARACTER SET utf8mb4");
                stmt.execute("SET character_set_connection=utf8mb4");
            }
            
            logger.info("MySQLデータベースに接続しました（UTF-8対応）");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQLドライバーが見つかりません", e);
        }
    }

    /**
     * データベース接続を閉じる
     */
    public void disconnect() {
        if (connection != null) {
            try {
                connection.close();
                logger.info("MySQLデータベース接続を閉じました");
            } catch (SQLException e) {
                logger.error("データベース接続のクローズに失敗しました", e);
            }
        }
    }

    /**
     * 全ユーザーを取得する
     * @return ユーザーリスト
     * @throws SQLException SQLエラー
     */
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, username, email, first_name, last_name, created_at FROM users";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                users.add(user);
            }
        }
        
        logger.info("{}件のユーザーを取得しました", users.size());
        return users;
    }

    /**
     * 全商品を取得する
     * @return 商品リスト
     * @throws SQLException SQLエラー
     */
    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT id, name, description, price, category, stock_quantity, created_at FROM products";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setCategory(rs.getString("category"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setCreatedAt(rs.getTimestamp("created_at"));
                products.add(product);
            }
        }
        
        logger.info("{}件の商品を取得しました", products.size());
        return products;
    }

    /**
     * データベースからデータを取得してSolrに同期する
     * @param solrService Solrサービス
     * @throws SQLException SQLエラー
     */
    public void syncDataToSolr(SolrService solrService) throws SQLException {
        try {
            connect();
            
            // ユーザーデータをSolrに同期
            List<User> users = getAllUsers();
            solrService.indexUsers(users);
            
            // 商品データをSolrに同期
            List<Product> products = getAllProducts();
            solrService.indexProducts(products);
            
            logger.info("データベースからSolrへの同期が完了しました");
            
        } finally {
            disconnect();
        }
    }
}
