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

    
    /*stage('validate_status') {
        sh '''
        echo "***********Validating Status***********"
        . ./request.sh
    '''
        def status = readFile('status.txt').trim()
        if (status == '200') {
            echo 'Status 200. Pipeline continue'
        } else {
            error("Status is not 200")
        }
    }*/

    stage('send_notification') {
        echo "The variable env_name is: ${env.env_name} and this returns status code 200"
        def build_user = currentBuild.getBuildCauses('hudson.model.Cause$UserIdCause')
        env.BUILD_USER = build_user.userName
        echo "The username is: ${env.BUILD_USER}"
        echo "The urls are: ${params.urls}"
    }

}