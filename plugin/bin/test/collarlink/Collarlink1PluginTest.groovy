/*
 * This Groovy source file was generated by the Gradle 'init' task.
 */
package collarlink

import org.gradle.testfixtures.ProjectBuilder
import org.gradle.api.Project
import spock.lang.Specification

/**
 * A simple unit test for the 'collarlink.greeting' plugin.
 */
class Collarlink1PluginTest extends Specification {
    def "plugin registers task"() {
        given:
        def project = ProjectBuilder.builder().build()

        when:
        project.plugins.apply("collarlink.greeting")

        then:
        project.tasks.findByName("greeting") != null
    }
}
