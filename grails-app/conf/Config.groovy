// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination

// The ACCEPT header will not be used for content negotiation for user agents containing the following strings (defaults to the 4 major rendering engines)
grails.mime.disable.accept.header.userAgents = ['Gecko', 'WebKit', 'Presto', 'Trident']
grails.mime.types = [ // the first one is the default format
                      all          : '*/*', // 'all' maps to '*' or the first available format in withFormat
                      atom         : 'application/atom+xml',
                      css          : 'text/css',
                      csv          : 'text/csv',
                      form         : 'application/x-www-form-urlencoded',
                      html         : ['text/html', 'application/xhtml+xml'],
                      js           : 'text/javascript',
                      json         : ['application/json', 'text/json'],
                      multipartForm: 'multipart/form-data',
                      rss          : 'application/rss+xml',
                      text         : 'text/plain',
                      hal          : ['application/hal+json', 'application/hal+xml'],
                      xml          : ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// Legacy setting for codec used to encode data with ${}
grails.views.default.codec = "html"

// The default scope for controllers. May be prototype, session or singleton.
// If unspecified, controllers are prototype scoped.
grails.controllers.defaultScope = 'singleton'

// GSP settings
grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside ${}
                scriptlet = 'html' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'none' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        // filteringCodecForContentType.'text/html' = 'html'
    }
}


grails.converters.encoding = "UTF-8"
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart = false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

// configure passing transaction's read-only attribute to Hibernate session, queries and criterias
// set "singleSession = false" OSIV mode in hibernate configuration after enabling
grails.hibernate.pass.readonly = false
// configure passing read-only to OSIV session by default, requires "singleSession = false" OSIV mode
grails.hibernate.osiv.readonly = false

// asset-pipeline
grails.assets.excludes = [
        'bower_components/**',
        '.sass-cache/**',
        'sass/**',
        'config.rb',
        'share/*.js'
]

grails.assets.plugin."resources".excludes =["**"]

environments {
    development {
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
    }
}

// log4j configuration
log4j.main = {
    // Example of changing the log pattern for the default console appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    if (System.getProperty("ELK_TCP_ADDR")) {
        appenders {
            console name: 'stdout', layout: pattern(conversionPattern: '%c{2} %m%n')
            appender new biz.paluch.logging.gelf.log4j.GelfLogAppender(name: 'central',
                    host: System.getProperty("ELK_TCP_ADDR"), port: 12201, additionalFields: "app_type= patient")
        }

        root { info "central", "stdout", "stacktrace" }
    }

    info 'com.ratchethealth.patient',
            'grails.app.domain',
            'grails.app.services',
            'grails.app.controllers',
            'grails.app.filters.com.ratchethealth.ratchet.LoggingFilters'

    error 'org.codehaus.groovy.grails.web.servlet',        // controllers
            'org.codehaus.groovy.grails.web.pages',          // GSP
            'org.codehaus.groovy.grails.web.sitemesh',       // layouts
            'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
            'org.codehaus.groovy.grails.web.mapping',        // URL mapping
            'org.codehaus.groovy.grails.commons',            // core / classloading
            'org.codehaus.groovy.grails.plugins',            // plugins
            'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
            'org.springframework',
            'org.hibernate',
            'net.sf.ehcache.hibernate'

    environments {
        development {
            debug 'com.ratchethealth.patient',
                    'grails.app.domain',
                    'grails.app.services',
                    'grails.app.controllers'
        }
    }
}

grails.resources.resourceLocatorEnabled = false
grails.plugin.cookiesession.enabled = true
grails.plugin.cookiesession.cookiename = "ratchet-session"
grails.plugin.cookiesession.sessiontimeout = 900

//grails.plugin.cookiesession.hmac.id = "grails-session-hmac"
grails.plugin.cookiesession.cryptoalgorithm = "HmacSHA1"
grails.plugin.cookiesession.secret = "ratchetByXplusz".bytes.encodeBase64(false).toString()

// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format
String defaultOverrideLocation = "classpath:resources/noredist/override.properties"
String systemOverrideLocation = System.getProperty("override")
String overrideLocation = systemOverrideLocation ? "file:${systemOverrideLocation}" : defaultOverrideLocation
grails.config.locations = [
        overrideLocation
]

if (System.getProperty("CDN_ENABLE")?.toBoolean() == true) {
    cdn_domain = System.getProperty("CDN_DOMAIN") ?: "http://d1ziekjz7irzny.cloudfront.net"
    grails.assets.url = "${cdn_domain}/assets/"
}

grails.cache.enabled = true

grails.cache.config = {
    provider {
        name 'ehcache-patient-portal-' + (new Date().format('yyyyMMddHHmmss'))
    }
    cache {
        name 'announcement'
    }
    defaultCache {
        memoryStoreEvictionPolicy 'LRU'
    }

    defaults {
        maxElementsInMemory 10
        eternal false
        overflowToDisk false
        maxElementsOnDisk 0
        timeToIdleSeconds 600
        timeToLiveSeconds 600
    }
}

ratchetv2 {
	server {
		url {
			base = System.getProperty("SERVER_URL") ?: "http://api.develop.ratchethealth.com/api/v1"

            // Client
            client {
                subDomain = "${ratchetv2.server.url.base}/clients?subDomain=%s"
            }

            // Email
            email {
                patientConfirmation = "${ratchetv2.server.url.base}/patient/confirm"
                emergencyContactConfirmation = "${ratchetv2.server.url.base}/caregiver/confirm"
                checkPhoneNumber = "${ratchetv2.server.url.base}/patients/%d/check_phone_number"
                unsubscribe = "${ratchetv2.server.url.base}/patients/%d/unsubscribe"
            }

            // Task
            task {
                oneTest = "${ratchetv2.server.url.base}/tests/%s"
                tests = "${ratchetv2.server.url.base}/tests"
            }

			addAssist = "${ratchetv2.server.url.base}/assist"

            // Announcement
            announcements = "${ratchetv2.server.url.base}/announcements"
        }
    }

    googleAnalytics {
        trackingId = System.getProperty("GA_TRACKING_ID") ?: "UA-60192214-1"
    }
}
