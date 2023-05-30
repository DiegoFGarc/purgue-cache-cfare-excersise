node {
    
    stage('validate_parameters') {
        def valuesText = params.env_name
        def valuesList = valuesText.split("\n")
        for (value in valuesList) {
            if (value.contains('ing') || value.contains('dev')) {
                echo "The env_name value is valid!: ${value}"
            } else {
                error("The env_name parameter value is invalid for: ${value}. Must be 'ing' or 'dev'.")
            }
        }
    }
    /*
    stage('get_status') {
        sh '''
        echo "***********Getting Status***********"
        ansible-playbook template.yml --extra-vars="env_name=$env_name"
        '''
    }

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
    }   
    */
    stage('cloudfare_api') {
        def valuesText = params.env_name
        def valuesList = valuesText.split("\n")
        def concatenatedValues = ""

        for (value in valuesList) {
            concatenatedValues += value.trim() + ","
        }

        // Elimina la última coma
        concatenatedValues = concatenatedValues[0..-2]

        // Asigna la variable de entorno
        env.MY_VARIABLE = concatenatedValues
        sh '''
        echo ${env.MY_VARIABLE}
        '''
    }

}