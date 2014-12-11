ratchet-v2-user-desktop
=======================

## Dependencies

1. JDK 1.7+
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

3. Install Homebrew

    - Open Terminal and run the following command:

    ```bash
       $ ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'
    ```
4. Install Ruby

   - Now that we have Homebrew installed, we can use it to install Ruby.We're going to use rbenv to install and manage our Ruby versions.To do this, run the following commands in your Terminal:

    ```bash
       $ brew install rbenv ruby-build
       # Add rbenv to bash so that it loads every time you open a terminal
       echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
       $ source ~/.bash_profile
       # Install Ruby 2.1.3 and set it as the default version
       $ rbenv install jruby-1.7.9
       $ rbenv global jruby-1.7.9
       $ ruby -v
       # jruby-1.7.9
    ```
5. Install Compass
   - After that, we can install compass.
   ```bash
      $ gem update --system
      $ gem install compass
   ```
6. Setup JRuby Path
   - Setting up the ruby environment for compass-sass plugin
   ```bash
      cd /etc
      $ sudo vim launchd.conf
      # added the following line to it
      setenv PATH /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin: your JRuby path
      # restarted your machine so that the new launchd config would take effect
   ```


## Run

1. run grails

    ```bash
        $ grails run-app
    ```

2. config BuildConfig
   - In BuildConfig.groovy, make the {run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false]} to be annotation. Just like this:

        grails.project.fork = [
            // configure settings for compilation JVM, note that if you alter the Groovy version forked compilation is required
            //  compile: [maxMemory: 256, minMemory: 64, debug: false, maxPerm: 256, daemon:true],

            // configure settings for the test-app JVM, uses the daemon by default
            test: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
            // configure settings for the run-app JVM
        //    run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
            // configure settings for the run-war JVM
            war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
            // configure settings for the Console UI JVM
            console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
        ]

3. synchronize Grails Settings
