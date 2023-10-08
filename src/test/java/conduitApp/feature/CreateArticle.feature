Feature: Tests for Create Article

  Background: Define URL
    Given url 'https://api.realworld.io/api/'
    Given path 'users/login'
    And request {"user": {"email": "venkikarate@gmail.com","password": "1992venkappa"}}
    When method POST
    Then status 200
    * def token = response.user.token

  Scenario: Create a new article
    Given header Authorization = 'Token '+ token
    Given path 'articles'
    And request {"article": {"title": "Testing2049","description": "ertete","body": "ettet","tagList": ["werwrwr"]}}
    When method POST
    Then status 201
    And match response.article.title == 'Testing2049'

  @CoderTest
  Scenario: Create and Delete a new article
    Given header Authorization = 'Token '+ token
    Given path 'articles'
    And request {"article": {"title": "Alexaviki1","description": "ertete","body": "ettet","tagList": ["werwrwr"]}}
    When method POST
    Then status 201
    And match response.article.title == 'Alexaviki1'
    
    * def articleid = response.article.slug
    
    Given header Authorization = 'Token '+ token
    Given params {limit: 20,offset: 0 }
    Given path 'articles'
    When method GET
    Then status 200
    And match response.articles[0].title == 'Alexaviki1'
    
    Given header Authorization = 'Token '+ token
    Given path 'articles',articleid
    When method DELETE
    Then status 204
    
     Given header Authorization = 'Token '+ token
    Given params {limit: 20,offset: 0 }
    Given path 'articles'
    When method GET
    Then status 200
    And match response.articles[0].title != 'Alexaviki1'
