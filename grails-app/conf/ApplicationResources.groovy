modules = {
    application {
        resource url:'js/application.js'
    }

       'app-js' {
		dependsOn 'angular'  // base angular modules
        resource url:'js/upcoming/app.js'
        resource url:'js/upcoming/nav_menu.js'
        resource url:'js/upcoming/angular.min.js'


    }

    'app' {
		// dependsOn 'angular'  // base angular modules
		// dependsOn 'angular-top'  // most common angular modules
		// dependsOn 'angular-all'  // all angular modules (without test scripts)
		dependsOn 'angular-all'  // enable this, as a sample ...
		dependsOn 'app-js'  // application-specific angular-related scripts ...
    }
}