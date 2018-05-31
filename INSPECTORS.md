Privacy & Terms inspectors for Redmine
======================================

### [Authentication](#authentication)

Authentication activation required. Otherwise all guest users (not logged in users) are also able to view content.

### [Protocol](#protocol)

Use HTTPS instead of HTTP to make sure every content is transfered encrypted. This is also a very important aspect in intranet solutions.

### [Admistrator amount](#admin_amount)

Limit the number of user accounts with administration rights. Ideally there should exist only one.

### [Password length](#password_min_length)

Make sure your password lenght is 8 or higher. Each additional character increases password security.


### [User role visibility all](#roles_users_visibility_all)

Roles with user visibility ALL - make sure if this is really necessary.

#### Example for user visibility

There is project A with:

*   User A
*   User B

There is project B with:

*   User B
*   User C

This is what user A sees with user visibility ALL:

*   User A
*   User B
*   User C

If you change user visibility of User A to "Members of visible projects" this user will only see:

*   User A
*   User B

The user does not see members of other projects, which makes more sense.

### [Inactive users](#inactive_users)

Registered users which have not been active in the system for more than 1 year. Please check those accounts in case they are not part of your team anymore. Maybe you should inactivate them.

### [Terms of use not accepted](#user_terms_not_accepted)

(will only be displayed if the terms of use policy is activated)

Displays the number of users who have not accepted the terms of use.

Users with administration rights are not counted. Those users do not need to accept the terms of use.

### [Never logged in users](#never_logedin_users)

Registerd users which have not logged in yet. Please check those accounts in case they are not part of your team anymore. Maybe you should delete them.

### [Public projects](#public_projects)

All public projects in your system. If users need to login all logged in users have access to them. If users don't need to log in on your system, every one has access to view the content.
