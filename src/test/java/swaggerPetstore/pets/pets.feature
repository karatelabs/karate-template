Feature: API Tests

  Background:
    * url 'http://localhost:8080/api/v3'

  # /pet POST 200
  Scenario: Add a new pet to the store
    Given path '/pet'
    And request { "id": 123, "name": "doggie", "photoUrls": ["string"], "status": "available" }
    When method post
    Then status 200

  # /pet POST 405
  Scenario: Invalid input for adding a new pet
    Given path '/pet'
    And request { "id": "invalid", "name": 12345 }
    When method post
    Then status 405

  # /pet PUT 200
  Scenario: Update an existing pet
    Given path '/pet'
    And request { "id": 123, "name": "doggie", "photoUrls": ["string"], "status": "available" }
    When method put
    Then status 200

  # /pet PUT 400
  Scenario: Invalid data for updating a pet
    Given path '/pet'
    And request { "id": "invalid", "name": 12345 }
    When method put
    Then status 400

  # /pet PUT 404
  Scenario: Update a non-existent pet
    Given path '/pet'
    And request { "id": 999999, "name": "nonexistent", "photoUrls": ["string"], "status": "available" }
    When method put
    Then status 404

  # /pet PUT 405
  Scenario: Method not allowed for updating a pet
    Given path '/pet'
    And request { "id": 123, "name": "doggie", "photoUrls": ["string"], "status": "available" }
    When method put
    Then status 405

  # /pet/findByStatus GET 200
  Scenario: Find pets by status
    Given path '/pet/findByStatus'
    And param status = 'available'
    When method get
    Then status 200

  # /pet/findByStatus GET 400
  Scenario: Invalid status value for finding pets
    Given path '/pet/findByStatus'
    And param status = 12345
    When method get
    Then status 400

  # /pet/findByTags GET 200
  Scenario: Find pets by tags
    Given path '/pet/findByTags'
    And param tags = 'tag1,tag2'
    When method get
    Then status 200

  # /pet/findByTags GET 400
  Scenario: Invalid tags value for finding pets
    Given path '/pet/findByTags'
    And param tags = 12345
    When method get
    Then status 400

  # /pet/{petId} GET 200
  Scenario: Find pet by ID
    Given path '/pet/123'
    When method get
    Then status 200

  # /pet/{petId} GET 400
  Scenario: Invalid ID supplied for finding pet
    Given path '/pet/invalid'
    When method get
    Then status 400

  # /pet/{petId} GET 404
  Scenario: Pet not found
    Given path '/pet/999999'
    When method get
    Then status 404

  # /pet/{petId} POST 405
  Scenario: Method not allowed for pet ID
    Given path '/pet/123'
    When method post
    Then status 405

  # /pet/{petId} DELETE 400
  Scenario: Invalid ID supplied for deleting pet
    Given path '/pet/invalid'
    When method delete
    Then status 400

  # /pet/{petId} DELETE 200
  Scenario: Delete a pet
    Given path '/pet/123'
    When method delete
    Then status 200

  # /pet/{petId}/uploadImage POST 200
  Scenario: Upload image for pet
    Given path '/pet/123/uploadImage'
    And multipart file image = { read: 'path/to/image.jpg', filename: 'image.jpg', contentType: 'image/jpeg' }
    When method post
    Then status 200

  # /pet/{petId}/uploadImage POST 400
  Scenario: Invalid image upload for pet
    Given path '/pet/123/uploadImage'
    And multipart file image = { read: 'path/to/invalid.txt', filename: 'invalid.txt', contentType: 'text/plain' }
    When method post
    Then status 400

  # /pet/{petId}/uploadImage POST 404
  Scenario: Upload image for non-existent pet
    Given path '/pet/999999/uploadImage'
    And multipart file image = { read: 'path/to/image.jpg', filename: 'image.jpg', contentType: 'image/jpeg' }
    When method post
    Then status 404
