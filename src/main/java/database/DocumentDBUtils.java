package database;

import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

public class DocumentDBUtils {
    private final MongoClient mongoClient;
    private final MongoDatabase database;

    public DocumentDBUtils(String uri, String dbName) {
        mongoClient = new MongoClient(new MongoClientURI(uri));
        database = mongoClient.getDatabase(dbName);
    }

    public MongoCollection<Document> getCollection(String collectionName) {
        return database.getCollection(collectionName);
    }

    public void close() {
        mongoClient.close();
    }
}