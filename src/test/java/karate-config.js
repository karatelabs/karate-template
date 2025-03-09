function fn() {
    var env = karate.env || 'dev';
    karate.log('karate.env system property was:', env);

    var envConfig = karate.read('classpath:config.json')[env];

    if (!envConfig) {
        throw new Error("Invalid environment: " + env);
    }

    var config = {
        env: env,
        baseUrl: envConfig.baseUrl,
        authToken: karate.properties['authToken'] || envConfig.authToken, // Load from system properties if available
        dbConfig: {
            host: envConfig.dbConfig.host,
            username: karate.properties['dbUser'] || envConfig.dbConfig.username, // Load from system properties
            password: karate.properties['dbPass'] || envConfig.dbConfig.password // Load from system properties
        }
    };

    karate.log('Config Loaded:',config)

    return config;
}
