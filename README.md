# Privacy & Terms plugin for Redmine

[![Rate at redmine.org](https://img.shields.io/badge/rate%20at-redmine.org-blue.svg?style=fla)](https://www.redmine.org/plugins/redmine_privacy_terms) [![Tests](https://github.com/AlphaNodes/redmine_privacy_terms/workflows/Tests/badge.svg)](https://github.com/AlphaNodes/redmine_privacy_terms/actions?query=workflow%3A"Run+Tests) ![Run Linters](https://github.com/AlphaNodes/redmine_privacy_terms/workflows/Run%20Linters/badge.svg)

## Features

* Adds https://cookieconsent.insites.com/ support (cookie agreement)
* Add terms support, which each user has to accept before using Redmine
* Add privacy and security [inspectors](https://github.com/alphanodes/redmine_privacy_terms/blob/master/INSPECTORS.md)
* multilingual support
* API support (if terms are required, API call throw forbitten till user accept terms)

## Requirements

* Redmine version >= 5.0
* Redmine Plugin: [additionals](https://github.com/alphanodes/additionals)
* Ruby version >= 3.0

## Installation

Install ``redmine_privacy_terms`` plugin for `Redmine`

    cd $REDMINE_ROOT
    git clone git://github.com/alphanodes/redmine_privacy_terms.git plugins/redmine_privacy_terms
    git clone git://github.com/alphanodes/additionals.git plugins/additionals
    bundle config set --local without 'development test'
    bundle install
    bundle exec rake redmine:plugins:migrate RAILS_ENV=production

Restart Redmine (application server) and you should see the plugin show up in the Plugins page.

## Usage

1. First of all, add a wiki page for the terms and a wiki page with information for those users who reject the agreement.
Don't forget to add the macros on the wiki page with the terms which implement the "accept" and "reject" buttons: {{terms_accept}} | {{terms_reject}}
If you want to use multiple languages, create a wiki page for each language. If no wiki page is available for a language, the default wiki page will be used.

E.g. "my_terms" (used as default), my_terms_de, my_terms_it, etc.

2. Second, go to the plugin settings and open the section "Terms of use". Enable the function and select your project and add your wiki pages that you have created before. Apply your changes.

3. Enable the Terms in settings.

If you did not specify wiki pages or projects, terms are not activated. Even if you assing a non-existing wiki page, terms are not activated. If all settings are correct, you'll find a "show" link behind the wiki page text field.

## Configuration

### Plugin settings

The plugin offers settings for:

* Cookie agreement
* Terms of use
* Tools

The "Inspect" section displays information on possible data protection problems you should try to fix.

### Permissions

There is a new permission "Show terms condition" available. Members with this permission can see the terms conditions of other users. A user can always see its own terms condition at his profile (if terms are activated).

## Available macros

### terms_accept

You can use title parameter, to overwrite button text. Eg. {{terms_accept(title=I understood)}}

For multilange support use title_de, title_es, etc..

### terms_reject

You can use title parameter, to overwrite button text. Eg. {{terms_reject(title=Let me out)}}

For multilange support use title_de, title_es, etc..

## Uninstall

Uninstall ``redmine_privacy_terms``

    cd $REDMINE_ROOT
    bundle exec rake redmine:plugins:migrate NAME=redmine_privacy_terms VERSION=0 RAILS_ENV=production
    rm -rf plugins/redmine_privacy_terms public/plugin_assets/redmine_privacy_terms

Restart Redmine (application server)

## License

This plugin is licensed under the terms of GNU/GPL v2.
See [LICENSE](LICENSE) for details.

## Redmine Copyright

The redmine_hedgedoc is a plugin extension for Redmine Project Management Software, whose Copyright follows.
Copyright (C) 2006-  Jean-Philippe Lang

Redmine is a flexible project management web application written using Ruby on Rails framework.
More details can be found in the doc directory or on the official website <http://www.redmine.org>

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
