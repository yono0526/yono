Feature: Use step definitions generated by factories

  Scenario: create a post and verify its attributes
    Given the following post exists:
      | Title       | Body                |
      | a fun title | here is the content |
    Then I should find the following for the last post:
      | title       | body                |
      | a fun title | here is the content |

  Scenario: create a post and verify its attributes without the trailing colon
    Given the following post exists
      | Title       | Body                |
      | a fun title | here is the content |
    Then I should find the following for the last post:
      | title       | body                |
      | a fun title | here is the content |

  Scenario: create a post without a table and verify its attributes
    Given a post exists with a title of "a fun title"
    Then I should find the following for the last post:
      | title       |
      | a fun title |

  Scenario: flexible English when creating posts
    Given an post exists with an title of "a fun title"
    Then I should find the following for the last post:
      | title       |
      | a fun title |

  Scenario: create a post with an underscore in an attribute name
    Given a post exists with an author ID of "5"
    Then I should find the following for the last post:
      | author_id |
      | 5         |

  Scenario: create several posts
    Given the following posts exist:
      | Title | Body   |
      | one   | first  |
      | two   | second |
      | three | third  |
    Then I should find the following for the last post:
      | title | body  |
      | three | third |
    And there should be 3 posts

  Scenario: create a post with a new author
    Given the following post exists:
      | Title   | Author   |
      | a title | ID: 123  |
    Then I should find the following for the last post:
      | title   | author_id |
      | a title | 123       |
    And I should find the following for the last user:
      | id  |
      | 123 |

  Scenario: create a post with an existing author
    Given the following user exists:
      | ID  | Name |
      | 123 | Joe  |
    And the following post exists:
      | Title   | Author    |
      | a title | Name: Joe |
    Then I should find the following for the last post:
      | title   | author_id |
      | a title | 123       |
    And there should be 1 user

  Scenario: create a titled post with a new author (inherited association)
    Given the following titled post exists:
      | Title               | Author  |
      | A Post with a Title | ID: 123 |
    Then I should find the following for the last post:
      | title               | author_id |
      | A Post with a Title | 123       |

  Scenario: create post with and without a category association
    Given the following users exist:
      | ID  | Name |
      | 123 | Joe  |
    And the following posts exist:
      | Title                      | Author    | Category          |
      | a title                    | Name: Joe | Name: programming |
      | a title without a category | Name: Joe |                   |
    Then I should find the following for the last post:
      | title                      | category_id |
      | a title without a category |             |

  Scenario: create a user without attributes
    Given a user exists
    Then there should be 1 user

  Scenario: create several users without attributes
    Given 3 users exist
    Then there should be 3 users

  Scenario: create several users with one attribute
    Given 3 users exist with a name of "John"
    Then there should be 3 users
    And I should find the following for the last user:
      | name |
      | John |

  Scenario: create instances of a factory with an underscore in its name
    Given an admin user exists with a name of "John"
    Then I should find the following for the last user:
      | name | admin |
      | John | true  |

  Scenario: create a several instances of a factory with an underscore in its name
    Given 3 admin users exist
    Then I should find the following for the last user:
      | admin |
      | true  |

  Scenario: use true values when creating instances
    Given the following user exists:
      | name | admin |
      | Bill | true  |
    Then I should find the following for the last user:
      | name | admin |
      | Bill | true  |

  Scenario: use false values when creating instances
    Given the following user exists:
      | name | admin |
      | Mike | false |
    Then I should find the following for the last user:
      | name | admin |
      | Mike | false |

  Scenario: Properly pluralize words
    Given the following categories exist:
      | name       |
      | Bed        |
      | Test Drive |
    And 2 categories exist
    And 2 categories exist with a name of "Future"
    Then there should be 6 categories

  Scenario: create a post with an existing category group
    Given the following category exists:
      | ID  | name    | category group |
      | 123 | fiction | Name: books    |
    And the following post exists:
      | Title                      | Author    | Category                    |
      | a title                    | Name: Joe | Category Group: Name: books |
    Then I should find the following for the last post:
      | title   | category_id |
      | a title | 123         |

  Scenario: create a post with an existing category group and a new category
    Given the following category group exists:
      | ID  | name  |
      | 456 | books |
    And the following post exists:
      | Title     | Author    | Category                    |
      | a title   | Name: Joe | Category Group: Name: books |
    Then I should find the following for the last post:
      | title   |
      | a title |
    And I should find the following for the last category:
      | category_group_id |
      | 456               |

  Scenario: factory name and attributes should not be case sensitive
    Given the following category exists:
      | name    | category group |
      | fiction | Name: books    |
    Then there should be 1 category
    Given the following Category exists:
      | name    | category group |
      | science | Name: books    |
    Then there should be 2 categories

  Scenario: factory name and attributes should not be case sensitive
    Given a user exists
    Then there should be 1 user
    Given a User exists
    Then there should be 2 Users

  Scenario: factory name and attributes should not be case sensitive
    Given 3 users exist
    Then there should be 3 users
    Given 3 Users exist
    Then there should be 6 Users

  Scenario: factory name and attributes should not be case sensitive
    Given a category exists with a name of "fiction"
    Then there should be 1 category
    Given a Category exists with a name of "science"
    Then there should be 2 Categories

  Scenario: factory name and attributes should not be case sensitive
    Given 3 categories exist with a name of "fiction"
    Then there should be 3 categories
    Given 3 Categories exist with a name of "science"
    Then there should be 6 Categories

  Scenario: step definitions work correctly with aliases
    Given the following person exists:
      | ID  | Name |
      | 123 | Joe  |
    Then I should find the following for the last user:
      | id  | name |
      | 123 | Joe  |

  Scenario: pass a FactoryGirl table as an argument and modify it
    Given these super users exist:
      | id  | Name |
      | 123 | Joe  |
    Then I should find the following for the last user:
      | id  | name | admin |
      | 123 | Joe  | true  |

  Scenario: Transform parses string data into array before assigning to an association
    Given the following tags exist:
      | name  |
      | funky |
      | cool  |
      | hip   |
    And the following post exists:
      | title       | tags      |
      | Tagged post | cool, hip |
    Then the post "Tagged post" should have the following tags:
      | name |
      | cool |
      | hip  |
    And the post "Tagged post" should not have the following tags:
      | name  |
      | funky |

  Scenario: step definitions work correctly with ORMs that have simple `columns`
    Given a simple column exists
    Then there should be 1 SimpleColumn

  Scenario: step definitions work correctly with model classes that simply have attribute names
    Given a named attribute model exists with a title of "a fun title"
    Then there should be 1 NamedAttributeModel
