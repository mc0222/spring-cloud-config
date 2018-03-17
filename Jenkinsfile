#!groovy
node {
    def git
    def commitHash
    def image

    stage('Checkout') {
        git = checkout scm
        commitHash = git.GIT_COMMIT
    }

    stage('Test') {
        sh './gradlew test || true'
    }

    stage('Build') {
        sh './gradlew build -x test'

    }

    stage('Build Docker Image') {
        image = docker.build("hubtea/spring-cloud-config")
    }

    stage('Archive') {
        parallel (
            "Archive Artifacts" : {
                archiveArtifacts artifacts: '**/build/libs/*.jar', fingerprint: true
            },

            "Docker Image Push" : {
                docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
                    app.push("${commitHash}")
                    app.push("latest")
                }
            }
        )
    }
}