import org.yaml.snakeyaml.Yaml

def config = new Yaml().load(readFileFromWorkspace('projects.yml'))

config.projects.each { project ->
    pipelineJob(project.name) {
        description("CI pipeline for ${project.name}")
        definition {
            cpsScm {
                scm {
                    git {
                        remote { url(project.repo) }
                        branch("*/${project.branch ?: 'main'}")
                    }
                }
                scriptPath(project.jenkinsfile ?: 'Jenkinsfile')
            }
        }
    }
}
