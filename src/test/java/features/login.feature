Feature: Simple API Test with Karate
  This feature demonstrates a basic Karate tesuoioi

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Get posts and verify response
    Given path 'posts'
    When method get
    Then status 200
    And match response[0].userId == 1
    And match response[0].id == 1
    And match response[0].title == '#string'

  Scenario: Create a new post
    Given path 'posts'
    And request { userId: 1, title: 'Hello Karate', body: 'This is a test post.' }
    And header Content-Type = 'application/json; charset=UTF-8'
    When method post
    Then status 201
    And match response.title == 'Hello Karate'
    And match response.userId == 1
