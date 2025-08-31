package com.example.dbapp.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 設定ファイルを読み込むユーティリティクラス
 */
public class ConfigLoader {
    private static final Logger logger = LoggerFactory.getLogger(ConfigLoader.class);
    private static final String CONFIG_FILE = "database.properties";

    /**
     * 設定ファイルを読み込む
     * @return 設定プロパティ
     * @throws IOException 設定ファイルの読み込みエラー
     */
    public static Properties loadConfig() throws IOException {
        Properties properties = new Properties();
        
        try (InputStream inputStream = ConfigLoader.class.getClassLoader()
                .getResourceAsStream(CONFIG_FILE)) {
            
            if (inputStream == null) {
                throw new IOException("設定ファイルが見つかりません: " + CONFIG_FILE);
            }
            
            properties.load(inputStream);
            logger.info("設定ファイルを正常に読み込みました: {}", CONFIG_FILE);
            
        } catch (IOException e) {
            logger.error("設定ファイルの読み込みに失敗しました: {}", CONFIG_FILE, e);
            throw e;
        }
        
        return properties;
    }
}
