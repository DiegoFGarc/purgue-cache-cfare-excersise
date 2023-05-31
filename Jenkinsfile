node {
    
    stage('validate_parameters') {
        def valuesText = params.urls
        def valuesList = valuesText.split("\n")
        for (value in valuesList) {
            if (value.contains('ing') || value.contains('dev')) {
                echo "The url value is valid!: ${value}"
            } else {
                error("The url parameter value is invalid for: ${value}. Must be 'ing' or 'dev'.")
            }
        }
    }

    stage('get_status') {
        withCredentials([string(credentialsId: 'token_cloudfare', variable: 'CLOUDFLARE_TOKEN')]) {
            sh '''
            echo "***********Generating Script***********"
            ansible-playbook template.yml --extra-vars="urls=$valuesList, token_cloudfare=$CLOUDFLARE_TOKEN"
            '''
        }
    }
    
    stage('cloudfare_api') {
        /*def valuesText = params.urls
        def valuesList = valuesText.split("\n")
        def concatenatedValues = ""

        for (value in valuesList) {
            concatenatedValues += value.trim() + ","
        }

        // Delete last comma
        concatenatedValues = concatenatedValues[0..-2]

        // Assign the environment variable
        env.MY_VARIABLE = concatenatedValues
        */
        sh 'bash requests.sh'
    }

    /*
    stage('validate_status') {
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
    }

    stage('send_notification') {
        echo "The variable env_name is: ${env.env_name} and this returns status code 200"
        def build_user = currentBuild.getBuildCauses('hudson.model.Cause$UserIdCause')
        env.BUILD_USER = build_user.userName
        echo "The username is: ${env.BUILD_USER}"

        withCredentials([usernamePassword(credentialsId: 'my-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {

    }   
    */

}