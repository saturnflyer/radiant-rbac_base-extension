# RBAC (Role Based Access Control) Base

This extension is used by authors of other extensions to hide those 
extensions from users based on admin defined groups. Standard Radiant
groups consist of admin and developer. This adds the ability
to create groups such as finance.

Installing:  
Run 'rake radiant:extensions:rbac_base:migrate'

Installing the public files:  
Run 'rake radiant:extensions:rbac_base:update'

RBAC Base adds a `roles` table, a `roles_users` table, and creates 
the `has_and_belongs_to_many` relationship between users and roles.

By default, a configuration setting will allow Admin users to see
everything. You may change this by setting

    Radiant::Config['roles.admin.sees_everything'] = 'false'
    
Then you can, for example, use extensions that require their own roles but
prevent your client from seeing unimportant technical details or areas that
may be beyond his or her understanding. So your client may be in the 'Admin'
role so that they can manage users, but would be restricted from seeing 
details from your extension.

See more details in HELP_developer.md

Built by Saturn Flyer http://www.saturnflyer.com