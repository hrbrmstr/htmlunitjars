
.PHONY: clean pkg deps run

pkg:
	mvn --quiet package
	cp target/htmlunit-1.0-SNAPSHOT.jar ../../inst/java

clean:
	mvn clean

deps:
	rm -f ../../inst/java/*.jar
	export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
	mvn dependency:copy-dependencies -DoutputDirectory=../../inst/java

new:
	export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
	mvn archetype:generate -DgroupId=is.rud.htmlunit -DartifactId=htmlunit -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
