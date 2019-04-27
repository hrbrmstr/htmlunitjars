.PHONY: clean pkg deps run

pkg:
	mvn --quiet package
	cp target/htmlunit-1.0-SNAPSHOT.jar ../../inst/java

clean:
	mvn clean

deps:
	rm ../../inst/java/*.jar
	mvn dependency:copy-dependencies -DoutputDirectory=../../inst/java

new:
	mvn archetype:generate -DgroupId=is.rud.htmlunit -DartifactId=htmlunit -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
