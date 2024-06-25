Feature: Petstore API Test Cases

  Background:
    * url 'http://localhost:8080/api/v3'

  Scenario: Add a new pet to the store with JSON
    Given path 'pet'
    And request { "id": 1, "name": "doggie", "photoUrls": ["http://example.com/photo"], "tags": [], "status": "available" }
    When method post
    Then status 200

  Scenario: Add a new pet to the store with XML
    Given path 'pet'
    And header Content-Type = 'application/xml'
    And request <Pet><id>1</id><name>doggie</name><photoUrls><photoUrl>http://example.com/photo</photoUrl></photoUrls><tags/><status>available</status></Pet>
    When method post
    Then status 200

  Scenario: Get a pet by ID with JSON
    Given path 'pet/1'
    When method get
    Then status 200
    And match response.id == 1

  Scenario: Get a pet by ID with XML
    Given path 'pet/1'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    And match response.Pet.id == 1

  Scenario: Update an existing pet with JSON
    Given path 'pet'
    And request { "id": 1, "name": "doggie_updated", "photoUrls": ["http://example.com/photo"], "tags": [], "status": "available" }
    When method put
    Then status 200

  Scenario: Update an existing pet with XML
    Given path 'pet'
    And header Content-Type = 'application/xml'
    And request <Pet><id>1</id><name>doggie_updated</name><photoUrls><photoUrl>http://example.com/photo</photoUrl></photoUrls><tags/><status>available</status></Pet>
    When method put
    Then status 200

  Scenario: Delete a pet by ID with JSON
    Given path 'pet/1'
    When method delete
    Then status 200

  Scenario: Delete a pet by ID with XML
    Given path 'pet/1'
    And header Accept = 'application/xml'
    When method delete
    Then status 200
