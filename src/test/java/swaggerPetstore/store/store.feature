Feature: Store API Test Scenarios

  Background:
    * url 'http://localhost:8080/api/v3'

  # /store/inventory GET 200
  Scenario: Get inventory of the store
    Given path '/store/inventory'
    When method get
    Then status 200

  # /store/order POST 200
  Scenario: Place a new order in the store
    Given path '/store/order'
    And request { "id": 123, "petId": 1, "quantity": 1, "shipDate": "2024-06-23T00:00:00.000+00:00", "status": "placed", "complete": true }
    When method post
    Then status 200

  # /store/order POST 405
  Scenario: Invalid input for placing a new order
    Given path '/store/order'
    And request { "id": "invalid", "petId": "invalid", "quantity": -1 }
    When method post
    Then status 405

  # /store/order/{orderId} GET 200
  Scenario: Get order by ID
    Given path '/store/order/123'
    When method get
    Then status 200

  # /store/order/{orderId} GET 400
  Scenario: Invalid ID supplied for getting order
    Given path '/store/order/invalid'
    When method get
    Then status 400

  # /store/order/{orderId} GET 404
  Scenario: Order not found
    Given path '/store/order/999999'
    When method get
    Then status 404

  # /store/order/{orderId} DELETE 400
  Scenario: Invalid ID supplied for deleting order
    Given path '/store/order/invalid'
    When method delete
    Then status 400

  # /store/order/{orderId} DELETE 404
  Scenario: Order to be deleted not found
    Given path '/store/order/999999'
    When method delete
    Then status 404

  # /store/order/{orderId} DELETE 200
  Scenario: Delete order by ID
    Given path '/store/order/123'
    When method delete
    Then status 200
