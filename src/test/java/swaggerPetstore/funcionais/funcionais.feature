Feature: Pet Store API Tests

  Background:
    * url 'http://localhost:8080/api/v3/'

  Scenario: Adotar um Pet
    Given path 'user'
    And request { "id": 1, "username": "user1", "firstName": "User", "lastName": "One", "email": "user1@example.com", "password": "password", "phone": "1234567890", "userStatus": 0 }
    When method post
    Then status 200

    Given path 'user', 'login'
    And param username = 'user1'
    And param password = 'password'
    When method get
    Then status 200

    Given path 'pet', 'findByStatus'
    And param status = 'available'
    When method get
    Then status 200
    And match response[0].id == '#notnull'
    * def petId = response[0].id

    Given path 'pet', petId
    When method get
    Then status 200

    Given path 'store', 'order'
    And request { "id": 1, "petId": petId, "quantity": 1, "shipDate": "2024-06-25T14:00:00.000Z", "status": "placed", "complete": true }
    When method post
    Then status 200

    Given path 'pet'
    And request { "id": petId, "name": "doggie", "status": "adopted" }
    When method put
    Then status 200

  Scenario: Gerenciamento de Estoque de Pets
    Given path 'user', 'login'
    And param username = 'admin'
    And param password = 'admin123'
    When method post
    Then status 200

    Given path 'pet'
    And request { "id": 2, "name": "kitty", "photoUrls": ["url1"], "tags": [], "status": "available" }
    When method post
    Then status 200

    Given path 'pet'
    And request { "id": 2, "name": "kitty", "photoUrls": ["url1"], "tags": [], "status": "pending" }
    When method put
    Then status 200

    Given path 'pet', 2
    When method delete
    Then status 200

  Scenario: Processo de Devolução de Pet
    Given path 'user', 'login'
    And param username = 'user1'
    And param password = 'password'
    When method get
    Then status 200

    Given path 'store', 'order'
    And request { "id": 2, "petId": 1, "quantity": 1, "shipDate": "2024-06-25T14:00:00.000Z", "status": "returned", "complete": true }
    When method post
    Then status 200

    Given path 'store', 'order', 2
    When method get
    Then status 200

    Given path 'pet'
    And request { "id": 1, "name": "doggie", "status": "available" }
    When method put
    Then status 200

    Given path 'store', 'order', 2
    When method delete
    Then status 200
