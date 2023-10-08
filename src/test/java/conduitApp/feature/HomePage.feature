Feature: Tests for Home Page
  
  Background: Define URL
  Given url 'https://api.realworld.io/api/'

  Scenario: Get All Tags
    Given path 'tags'
    When method GET
    Then status 200

  Scenario: Get 10 Articles from the page
    Given param limit = 10
    Given param offset = 0
    Given path 'articles'
    When method GET
    Then status 200

  Scenario: Get 20 Articles from the page
    Given params {limit: 20,offset: 0 }
    Given path 'articles'
    When method GET
    Then status 200
