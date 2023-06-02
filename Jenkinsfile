node {
    
    stage('validate_parameters') {
        def valuesText = params.urls
        def valuesList = valuesText.split("\n")
        for (value in valuesList) {
            if (value.contains('https://embed-env.cartfulsolutions.com') || value.contains('https')) {
                echo "The url value is valid!: ${value}"
            } else {
                error("The url parameter value is invalid for: ${value}. Must be 'https://embed-env.cartfulsolutions.com' or 'https'.")
            }
        }
    }
    stage('get_status') {
        sh 'pwd'
        sh 'ls'
    }

    stage('get_status') {
        withCredentials([
            string(credentialsId: 'token_cloudfare', variable: 'CLOUDFLARE_TOKEN'),
            string(credentialsId: 'cloudfare_zone_id', variable: 'CLOUDFLARE_ZONE_ID')
        ]){
            def valuesText = params.urls
            def valuesList = valuesText.split("\n")
            def concatenatedValues = ""

            for (value in valuesList) {
                concatenatedValues += value.trim() + ","
            }

        // Delete last comma
            concatenatedValues = concatenatedValues[0..-2]

        // Assign the environment variable
            env.MY_VARIABLE = concatenatedValues
            sh '''
            echo "***********Generating Script***********"
            ansible-playbook template.yml --extra-vars="urls=$MY_VARIABLE token_cloudfare=$CLOUDFLARE_TOKEN zone_id=$CLOUDFLARE_ZONE_ID"
            '''
        }
    }
    
    stage('cloudfare_api') {
        sh 'bash requests.sh PurgeCache'
    }

    stage('send_notification') {
        def build_user = currentBuild.getBuildCauses('hudson.model.Cause$UserIdCause')
        env.BUILD_USER = build_user.userName
        echo "${env.BUILD_USER} purged cache for the following development resources: \n ${params.urls}"
    }

}