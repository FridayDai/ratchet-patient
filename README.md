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

## Run

1. run grails

       ```bash
        $ grails run-app
       ```

2. config BuildConfig

      In BuildConfig.groovy, make the {run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false]} to be annotation. Just like this:

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
