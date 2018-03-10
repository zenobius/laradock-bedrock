# WP Mesh

A containerized docker environment for WordPress.

This is a fork of [Laradock](https://github.com/laradock/laradock) prepared to work with WordPress boilerplate [Bedrock](https://github.com/roots/bedrock).


## What is different?
 - Document root points to /var/www/web
 - WP-CLI is installed by default
 - Composer is installed by default
 - MySQLi extension is enabled by default
 - contains script to shorten certain commands
 
## Installation

1. Clone this repository into a subdirectory of your Bedrock installation. If you want to stay up to date, you might want to use git submodules or git-subrepo.

       git clone https://github.com/lukasbesch/laradock-bedrock.git docker

2. (Optional) Copy the `env-example` to `.env` in your docker folder. Checkout its options and adjust them as needed.
3. In your project's `.env` file Set the `DB_HOST` constant to the corresponding container `mariadb` or `mysql`

       DB_HOST=mariadb
4. Create docker containers. This will also create

       ./laradock.sh create
       
5. Install Composer Packages

       ./laradock.sh -- composer install
       
Your site should be available at [http://localhost](http://localhost).

You could also use dnsmasq on your local machine to route all traffic with the TLD *.docker to localhost. Now you are able to give each of your sites a custom hostname such as [http://mysite.docker](http://mysite.docker). This is very convenient for the use with password managers. 

## Documentation     
Please checkout the official docs: https://github.com/laradock/laradock

## Roadmap

- [ ] Extend Documentation

- [x] Basic Webserver Setup (nginx or Apache2, PHP-fpm, MariaDB or MySQL)

- [ ] `dnsmasq` instructions

- [ ] Add support for multiple sites and setups

- [ ] Deployment to AWS via Ansible

- [ ] Secure for use in production

#### Check/add support for laradock containers: ####

- [x] Apache2

- [x] nginx

- [x] PHP-fpm

- [x] MySQL

- [x] MariaDB

- [ ] Redis

- [ ] MemCached

- [ ] HHVM

- [ ] Caddy

- [ ] Varnish

- [ ] HAProxy

- [ ] MailDev/MailHog

- [ ] phpMyAdmin

- [ ] certbot/letsencrypt

