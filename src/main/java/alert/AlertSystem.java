package alert;

public class AlertSystem {

    public void triggerAlert(String transactionJson, DetectionResult detectionResult) {
        // Parse the transaction JSON into a Transaction object
        Transaction transaction = parseTransaction(transactionJson);

        // Implement alert logic here
        String alertMessage = createAlertMessage(transaction, detectionResult);

        // Send the alert
        sendAlert(alertMessage);
    }

    private Transaction parseTransaction(String transactionJson) {
        // Parse JSON into a Transaction object
        // This is a placeholder for actual JSON parsing logic
        return new Transaction(transactionJson);
    }

    private String createAlertMessage(Transaction transaction, DetectionResult detectionResult) {
        // Create a message based on transaction and detection result
        return String.format("Alert: Suspicious transaction detected! Type: %s, Amount: %.2f, Status: %s, Confidence: %.2f",
                transaction.getType(), transaction.getAmount(), detectionResult.getStatus(), detectionResult.getConfidenceLevel());
    }

    private void sendAlert(String alertMessage) {
        // Placeholder for sending alert logic
        // This could be an email, SMS, log entry, etc.
        System.out.println(alertMessage);
    }
}