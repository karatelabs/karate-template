Feature: Fraud Detection using DocumentDB

  Background:
    * def DocumentDBUtils = Java.type('database.DocumentDBUtils')
    * def dbUtils = new DocumentDBUtils('mongodb://localhost:27017', 'fraudDB')
    * def printMessage = function(msg) { Java.type('java.lang.System').out.println(msg) }
    * def fraudRule = dbUtils.getFraudDetectionRule('rule1')

  @login @smoke
  Scenario: Detect high transaction volume
    * print 'Fraud Detection Rule:', fraudRule
    And request { transactionId: '12345', amount: 1500.0 }
    When method POST
    Then status 200
    And match response == { action: 'alert' }

  @login @security
  Scenario: Detect multiple refunds
    * def refundRule = MongoDBUtils.getFraudDetectionRule('rule2')
    * print 'Refund Detection Rule:', refundRule
    And request { transactionId: '12346', refundCount: 6 }
    When method POST
    Then status 200
    And match response == { action: 'review' }

  Scenario: Detect suspicious login attempts
    * def loginRule = MongoDBUtils.getFraudDetectionRule('rule3')
    * print 'Login Detection Rule:', loginRule
    And request { userId: '67890', failedAttempts: 5, location: 'unknown' }
    When method POST
    Then status 200
    And match response == { action: 'alert' }

  Scenario: Monitor large withdrawals
    * def withdrawalRule = MongoDBUtils.getFraudDetectionRule('rule4')
    * print 'Withdrawal Detection Rule:', withdrawalRule
    And request { transactionId: '12347', amount: 5000.0 }
    When method POST
    Then status 200
    And match response == { action: 'review' }

  Scenario: Identify rapid transactions
    * def rapidTransactionRule = MongoDBUtils.getFraudDetectionRule('rule5')
    * print 'Rapid Transaction Detection Rule:', rapidTransactionRule
    And request { userId: '67891', transactionCount: 10, timeFrame: '5 minutes' }
    When method POST
    Then status 200
    And match response == { action: 'alert' }



