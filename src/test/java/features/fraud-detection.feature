Feature: Fraud Detection Testing for Petstore API

  Background:
    * def baseUrl = 'https://petstore.swagger.io/v2'
    * url baseUrl

  Scenario: Attempt to add pet with suspicious name (SQL Injection)
    Given path 'pet'
    And request
    """
    {
      "id": 9999,
      "category": { "id": 1, "name": "Animals" },
      "name": "Fluffy'; DROP TABLE pets;--",
      "photoUrls": ["https://example.com/dog.jpg"],
      "tags": [{ "id": 1, "name": "Friendly" }],
      "status": "available"
    }
    """
    When method POST
    Then status 200


  Scenario: Purchase a pet that does not exist (Carding Attack)
    Given path 'store/order'
    And request
    """
    {
      "id": 5000,
      "petId": 123456,
      "quantity": 1,
      "shipDate": "2025-03-02T15:19:48.721Z",
      "status": "placed",
      "complete": true
    }
    """
    When method POST
    Then status 200


  Scenario: Multiple failed login attempts (Brute Force Attack)
    * def maxAttempts = 3
    * def username = 'fraud_user'
    * def password = 'wrongpassword'
    * def responseCodes = []

    * eval
    """
    for (var i = 0; i < maxAttempts; i++) {
        var res = karate.call('classpath:features/login.feature', { username: username, password: password });
        responseCodes.push(res.responseStatus);
    }
    """

    * match responseCodes contains 200
    * karate.log('Responses:', responseCodes)


  Scenario: Single failed login attempt
    * def username = 'fraud_user'
    * def password = 'wrongpassword'

    Given path 'user/login'
    And param username = username
    And param password = password
    When method GET
    Then status 200

  Scenario: Register account with suspicious data (Synthetic Identity Fraud)
    Given path 'user'
    And request
    """
    {
      "id": 77777,
      "username": "fake_user",
      "firstName": "John",
      "lastName": "Doe",
      "email": "not_a_real_email@fraud.com",
      "password": "FakePass123",
      "phone": "1234567890",
      "userStatus": 1
    }
    """
    When method POST
    Then status 200

  Scenario: Attempt to log in with leaked credentials (Credential Stuffing)
    * def username = 'admin'
    * def passwordList = read('classpath:passwords.json').passwords  # Externalized passwords
    * def responseCodes = []

    * eval
    """
    karate.repeat(passwordList.length, function(i) {
        var res = karate.call('classpath:features/login.feature', { username: username, password: passwordList[i] });
        responseCodes.push(res.responseStatus);
    });
    """

    * match responseCodes contains 200
    * karate.log('Responses:', responseCodes)

  Scenario: Consume message from Kafka
    * def kafkaUtils = Java.type('kafka.KafkaUtils')
    * def kafka = new kafkaUtils('localhost:9092', 'test-topic')
    * def message = kafka.consumeMessage()
    * print 'Consumed message: ', message
    * match message == 'risk'