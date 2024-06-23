Feature: API Test Cases

  Background:
    * url 'http://localhost:8080/api/v3/'

  Scenario: /user/createWithList POST 200
    Given path 'user/createWithList'
    And request [{ "id": 1, "username": "user1", "firstName": "First", "lastName": "Last", "email": "user1@example.com", "password": "password", "phone": "1234567890", "userStatus": 1 }]
    When method post
    Then status 200

  Scenario: /user/login GET 200
    Given path 'user/login'
    And param username = 'user1'
    And param password = 'password'
    When method get
    Then status 200

  Scenario: /user/login GET 400
    Given path 'user/login'
    And param username = 'invaliduser'
    And param password = 'invalidpassword'
    When method get
    Then status 400

  Scenario: /user/{username} GET 200
    Given path 'user/user1'
    When method get
    Then status 200

  Scenario: /user/{username} GET 400
    Given path 'user/invalidusername'
    When method get
    Then status 400

  Scenario: /user/{username} GET 404
    Given path 'user/nonexistentuser'
    When method get
    Then status 404

  Scenario: /user/{username} DELETE 400
    Given path 'user/invalidusername'
    When method delete
    Then status 400

  Scenario: /user/{username} DELETE 404
    Given path 'user/nonexistentuser'
    When method delete
    Then status 404

  Scenario: /user POST 200
    Given path 'user'
    And request { "id": 2, "username": "user2", "firstName": "First", "lastName": "Last", "email": "user2@example.com", "password": "password", "phone": "1234567890", "userStatus": 1 }
    When method post
    Then status 200

  Scenario: /user/logout GET 200
    Given path 'user/logout'
    When method get
    Then status 200

  Scenario: /user/{username} PUT 404
    Given path 'user/nonexistentuser'
    And request { "id": 9999, "username": "nonexistentuser", "firstName": "First", "lastName": "Last", "email": "nonexistent@example.com", "password": "password", "phone": "1234567890", "userStatus": 1 }
    When method put
    Then status 404

  Scenario: /user/{username} PUT 200
    Given path 'user/user1'
    And request { "id": 1, "username": "user1", "firstName": "UpdatedFirst", "lastName": "UpdatedLast", "email": "updated@example.com", "password": "newpassword", "phone": "0987654321", "userStatus": 1 }
    When method put
    Then status 200

  Scenario: /user/{username} DELETE 200
    Given path 'user/user1'
    When method delete
    Then status 200

