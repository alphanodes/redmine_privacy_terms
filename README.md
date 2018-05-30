Privacy & Terms plugin for Redmine
==================================

Features
--------

* Adds https://cookieconsent.insites.com/ support (cookie agreement)
* Add terms support, which each user has to accept before using Redmine
* Add privacy and security [inspectors](https://github.com/alphanodes/redmine_privacy_terms/blob/master/INSPECTORS.md)

Requirements
------------

* Redmine version >= 3.0.0
* Redmine Plugin: [additionals](https://github.com/alphanodes/additionals)
* Ruby version >= 2.1.5


Installation
------------

Install ``redmine_privacy_terms`` plugin for `Redmine`

    cd $REDMINE_ROOT
    git clone git://github.com/alphanodes/redmine_privacy_terms.git plugins/redmine_privacy_terms
    git clone git://github.com/alphanodes/additionals.git plugins/additionals
    bundle install --without development test
    bundle exec rake redmine:plugins:migrate RAILS_ENV=production

Restart Redmine (application server) and you should see the plugin show up in the Plugins page.


Usage
-----

1. Add wiki page for the terms and wiki page that will be shown when a user rejects the agreement.
Add on the terms wiki page links to accept and reject the agreement: {{terms_accept}} | {{terms_reject}}

If you want to use multiple languages, create a wiki page for each language. If no wiki page is available for a language, default wiki page will be used.

E.g. /projects/my_project/wiki/terms (used as default), /projects/my_project/wiki/terms_de, /projects/my_project/wiki/terms_it, etc.

2. Add urls of the pages to settings without domain. For example, if url is 'https://my_domain.com/projects/my_project/wiki/terms'
then you need to add to settings '/projects/my_project/wiki/terms'.

3. Enable the Terms in settings.


Configuration
-------------

### Plugin settings




### Permissions

There is a new permission "Show terms condition" available. Members with this permission can see the terms conditions of other users. A user can always see its own terms condition at his profile (if terms are activated).


Available macros
----------------

### terms_accept

You can use title parameter, to overwrite button text. Eg. {{terms_accept(title=I understood)}}

For multilange support use title_de, title_es, etc..

### terms_reject

You can use title parameter, to overwrite button text. Eg. {{terms_reject(title=Let me out)}}

For multilange support use title_de, title_es, etc..



Uninstall
---------

Uninstall ``redmine_privacy_terms``

    cd $REDMINE_ROOT
    bundle exec rake redmine:plugins:migrate NAME=redmine_privacy_terms VERSION=0 RAILS_ENV=production
    rm -rf plugins/redmine_privacy_terms public/plugin_assets/redmine_privacy_terms

Restart Redmine (application server)
