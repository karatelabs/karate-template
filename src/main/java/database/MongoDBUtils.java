package database;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoClient;
import org.bson.Document;

//using this class for FraudDetection.feature only
public class MongoDBUtils {

    private static final String CONNECTION_STRING = "mongodb://localhost:27017";
    private static final String DATABASE_NAME = "myDatabase";
    private static final String COLLECTION_NAME = "fraudDetectionRules";

    public static Document getFraudDetectionRule(String ruleId) {
        MongoClient client = null;
        try {
            client = MongoClients.create(CONNECTION_STRING);
            MongoDatabase database = client.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);
            Document query = new Document("ruleId", ruleId);
            Document rule = collection.find(query).first();
            if (rule == null) {
                throw new RuntimeException("Fraud detection rule not found for ruleId: " + ruleId);
            }
            return rule;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error retrieving fraud detection rule: " + e.getMessage());
        } finally {
            if (client != null) {
                client.close();
            }
        }
    }
}