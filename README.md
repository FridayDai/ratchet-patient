ratchet-v2-user-desktop
=======================

## Dependencies

1. JDK 1.8+
2. Grails 2.4.4
    - Install **gvm**
             Go to [gvm home page](http://gvmtool.net/) and install

    ```bash
        $ curl -s get.gvmtool.net | bash
    ```
    - Install **grails**

    ```bash
        $ gvm install grails
    ```

## Compass

1. Install **Homebrew**

    ```
        ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'
    ```
2. Install **Ruby**

  		 - Now that we have Homebrew installed, we can use it to install Ruby.
   		 We're going to use rbenv to install and manage our Ruby versions.
   		 To do this, run the following commands in your Terminal:

    ```
       brew install rbenv ruby-build

       # Add rbenv to bash so that it loads every time you open a terminal
       echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
       source ~/.bash_profile

       # Install Ruby 2.0.0 and set it as the default version
       rbenv install 2.0.0-p247
       rbenv global 2.0.0-p247

       # Check ruby version
       ruby -v
    ```
3. Install **Compass**

    ```
        gem update --system
        gem install compass
    ```

## Developing

	```
        grails run-app
        //If running on localhost should add NOT_SUPPORT_HTTPS ENV variable to true, as:
        grails run-app -DNOT_SUPPORT_HTTPS=true
    ```
    
    ```
        npm install
        bower install
        npm start
    ```

## CDN
1. The variable CDN_ENABLE should be set as 'true' in env configuration.
2. Set one custom origin instance of clouldfront.
2. The variable CDN_ASSET_DOMAIN_PATIENT should be set with clouldfront asset instance domain name.

## Configuration Variables

- ELK_TCP_ADDR
- SERVER_URL
- GA_TRACKING_ID
- CDN_ENABLE    // true | false | not define
- CDN_ASSET_DOMAIN_PATIENT    // just cloudfront url domain like: ```https://d1gdqclzwn7f9.cloudfront.net```
- NOT_SUPPORT_HTTPS    # true | false | not define
- IS_ROOT_CONTEXT_EXTRA_PATH
