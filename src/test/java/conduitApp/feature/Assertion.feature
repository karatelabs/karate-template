Feature: Tests for Home Page

  Background: Define URL
    Given url 'https://api.realworld.io/api/'


  Scenario: Get All Tags
    Given path 'tags'
    When method GET
    Then status 200
    And match response.tags contains ['codebaseShow']
    And match response.tags !contains ['quil']
    And match response.tags == "#array"
    And match each response.tags == "#string"


  Scenario: Get 10 Articles from the page
    Given param limit = 10
    Given param offset = 0
    Given path 'articles'
    When method GET
    Then status 200
    And match response.articles == '#[10]'


  Scenario: Get 20 Articles from the page
    Given params {limit: 20,offset: 0 }
    Given path 'articles'
    When method GET
    Then status 200
    And match response.articles == '#[20]'
    And match response.articlesCount == 197
    And match response.articlesCount != 199
    And match response == {"articles": "#array" ,"articlesCount": 197}
    And match response.articles[0].createdAt contains '2022'
    And match response.articles[*].favoritesCount contains 246
    And match response..bio contains null
    And match each response..following == false
    And match each response..following == '#boolean'
    And match each response..favoritesCount == '#number'
    And match each response..bio == '##string'
