package fraud;

public class Transaction {
    private String type;
    private double amount;
    private String currency;
    private String timestamp;

    public Transaction(String json) {
        // Parse JSON and initialize fields
        // This is a placeholder for actual parsing logic
    }

    public String getType() {
        return type;
    }

    public double getAmount() {
        return amount;
    }

    public String getCurrency() {
        return currency;
    }

    public String getTimestamp() {
        return timestamp;
    }

    // Add other getters and logic as needed
}