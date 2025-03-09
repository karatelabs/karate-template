Feature: Login API Testing

  Background:
    * url baseUrl

  Scenario: Attempt login with invalid credentials
    Given path 'user/login'
    And param username = username
    And param password = password
    When method GET
    Then status 200
