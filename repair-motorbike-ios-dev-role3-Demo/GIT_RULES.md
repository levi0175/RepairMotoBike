### Git Workflow

**Git structure infomation:**

| Branch         | Author     | Description                                                                    |
| :------------- | :--------- | :----------------------------------------------------------------------------- |
| release/\*     | Maintainer | Production branch for released versions to customer                            |
| develop/\*     | Maintainer | Branch for development version of product, contains lastest completed features |
| dev/feature/\* | Developer  | Branch for creating new features and functions                                 |
| bug/\*         | Developer  | Branch for bugs resolution                                                     |

**Git workflow guideline:**

1.  Naming branch:

    - For release/develop:
      - [*] is main.
      - Example: _develop/main_, _develop/main-sprint2_, _release/main_, ...
    - For dev:
      - [feature] is Main Function (english) in file estimate.
      - [*] is _main_ OR _Task-ID_.
      - Example: _dev/common/main_, _dev/login/main_, _dev/login/task-ui_, _dev/login/task-logic_ ...
    - For bug:
      - [*] is bug id
      - Example: _bug/bug-69_, _bug/bug-96_ ...

2.  Checkout:

    -     PM and Team Lead create *release/** and *develop/**
    - Team Lead define feature and create branch with template: _dev/feature/main_
    - Member:
      - Implement new feature: checkout and create branch from main with template: _dev/feature/jira-id_
      - Fix bug: create branch with template: _bug/bug-id_

3.  Commit message should be in template: task - taskDetail, examples:

    - task-ui - create readme file
    - task-ui - update readme file
    - bug-69 - fix bug id 69

4.  Member create merge request with following infomation:

    | Item          | Implementation                                                                                                                                                                                                                                                                                                               | Fix Bug                                                                                                                                                                                                                                                                                               |
    | :------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | Title         | [Feature][function] Description Text                                                                                                                                                                                                                                                                                         | [FixBug][bugid] Description Text                                                                                                                                                                                                                                                                      |
    | Description   | [Reference] <br/> The reference document/ticket of task <br/><br/> [Implementation] <br/> How do you implement this MR <br/> Explain the modification <br/><br/> [Side Effects] <br/> The side effects/impact of this MR <br/><br/> [Evidence] <br/> The evidence of the modification, included screen shot / recorded video | [Root cause] <br/> The root cause of the bug <br/><br/> [Solution] <br/> How do you fix the bug <br/> Explain the modification <br/><br/> [Side Effects] <br/> The side effects/impact of this MR <br/><br/> [Evidence] <br/> The evidence of the modification, included screen shot / recorded video |
    | Assignee      | Team Lead, SA                                                                                                                                                                                                                                                                                                                | Team Lead, SA                                                                                                                                                                                                                                                                                         |
    | Squash Commit | Enable <br/> Reviewer set squash commit message with template below <br/> [Feature][function] Description Text                                                                                                                                                                                                               | Enable <br/> Reviewer set squash commit message with template below <br/> [FixBug][bugid] Description Text                                                                                                                                                                                            |
    | Swiftlint     | Passed                                                                                                                                                                                                                                                                                                                       | Passed                                                                                                                                                                                                                                                                                                |

5.  Merge rule:

    - Create merge request and merge to main branch after feature is fully verified.
    - Merge to _dev/feature/main_ required squash commit.
    - Merge to _bug/bug-id_ required squash commit.
    - Merge _dev/feature/main_ to \*develop/\*\* is normal (NOT required squash commit).
