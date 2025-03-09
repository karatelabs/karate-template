Feature: Create A new Pet

  Background: The Request Body Configuration
      # Set a configuration for the payload
    * url baseUrl
    * def requestPayload = read('classpath:payload/pet.json')
    * set requestPayload.id = Java.type('utils.TestDataCreator').getID()
    * set requestPayload.category.id = Java.type('utils.TestDataCreator').getID()
    * set requestPayload.category.name = Java.type('utils.TestDataCreator').getDogCategoryName()
    * set requestPayload.name = Java.type('utils.TestDataCreator').getDogName()
    * set requestPayload.photoUrls[0] = Java.type('utils.TestDataCreator').getFileName()
    * set requestPayload.tags[0].name = requestPayload.name
    * set requestPayload.status = Java.type('utils.TestDataCreator').getStatus()[0]

  Scenario: Add a new pet to the store
    Given header Content-Type = 'application/json'
    And path '/v2/pet'
    And request requestPayload
    When method post
    Then status 200
    And match response.id == '#present'
    And match $.name == requestPayload.name
    And match $.category.name == requestPayload.category.name
    And match $.status == requestPayload.status
    # Find the pet by ID
    Given header Content-Type = 'application/json'
    And path '/v2/pet/' + response.id
    When method get
    Then status 200
    And match $.id == requestPayload.id
    And match $.category.id == requestPayload.category.id
    And match $.category.name == requestPayload.category.name
    And match $.name == requestPayload.name






