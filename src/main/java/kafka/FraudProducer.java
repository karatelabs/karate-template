package kafka;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import java.util.Properties;

public class FraudProducer {
    private final KafkaProducer<String, String> producer;

    public FraudProducer(String bootstrapServers) {
        Properties props = new Properties();
        props.put("bootstrap.servers", bootstrapServers);
        props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        producer = new KafkaProducer<>(props);
    }

    public void sendFraudMessage(String topic, String message) {
        producer.send(new ProducerRecord<>(topic, message));
    }

    public void close() {
        producer.close();
    }

    public static void main(String[] args) {
        FraudProducer producer = new FraudProducer("localhost:9092");
        producer.sendFraudMessage("fraud-topic", "{\"type\": \"risk\", \"amount\": 1000, \"currency\": \"USD\", \"timestamp\": \"2025-03-13T06:50:10.849Z\"}");
        producer.close();
    }
}
