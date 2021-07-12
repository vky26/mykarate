# mykarate

Karate: 
Course URL: https://qttechacademy.udemy.com/course/karate-dsl-api-automation-and-performance-from-zero-to-hero/learn/lecture/22174566#overview

To set up of api, we do use dummy ui app.

Steps:
1. Clone the repo - https://github.com/gothinkster/angular-realworld-example-app
2. open the terminal and 'yarn install'
3. npm start - will publish the app in http://localhost:4200/
4. Inspect the calls and for API and set it up in Postman
5. Created a Sample Tag Request, based on network details from the osted app. Once the setup is done, move to karate framework

Karate Framework:
1. Git url: https://github.com/intuit/karate
2. Create a folder for this FW, and follow the steps from quickstart - https://github.com/intuit/karate#quickstart
3. Import and explore
4. To Run, open termninal from VS Code and mvn test will run the default two cases

Tips/ Notes:
1. All the feature files present in the same folder / sub folder of Runner file, will only be picked

Plugins:
1. Matirial Icon Theme - for all file and folder icon
2. Cucumber (Gherkin) Full
3. Java Extension Pack
4. Karate Runner
5. Open in Default browser
6. Docker Plugin 

------------

Execution single feature file / tags

Efficient way:
mvn test "-Dkarate.options=--tags @debug" 
mvn test "-Dkarate.options=--tags @assertions"


Runner File: org.junit.jupiter.api.Test;

------------

Run cmd to switch env

mvn test "-Dkarate.options=--tags @configTest" -Dkarate.env="dev"
mvn test "-Dkarate.options=--tags @configTest" -Dkarate.env="qa"

------------

Configure Global Header 

callSingle is the method, take the parameter of the feature file, take a object which holds username and password, and last value after '.' is where the value will get stored



All the values in config file will be available for all the feature files



  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token' + accessToken})


  -------

  Schema validations:

  https://github.com/intuit/karate/blob/master/karate-junit4/src/test/java/com/intuit/karate/junit4/demos/schema-like.feature


  -------
  Java Faker - For Random test data generator

  We can generate the Java file method inside feature file

  under """ """ 

    -------


  @parallel = false on feature/scneario / scenario outline file will exclude that particular feature from running in parallel 
  otherwise change in the runner for number of thread counts, so you can 

  --------

  To enable cucumber reports 
  https://github.com/damianszczepanik/cucumber-reporting 

  add maven, add the method in your runner file and call that method from runner file


  Method available in - https://github.com/intuit/karate/tree/master/karate-demo

  https://github.com/intuit/karate/blob/master/karate-demo/src/test/java/demo/DemoTestParallel.java#L43
  
    --------

Execution of Karate in Docker Container

1. Download and login in Docker Desktop
2. Create a file 'Dockerfile' exactly same in root directory
3. Since our project is maven, lets pull the latest maven docker image from docker hub
          https://hub.docker.com/layers/maven/library/maven/3.6.3-jdk-11/images/sha256-1801d353e27e68d60355b371ddfd2ed8d06204bc3266f1746fdade897bb8b6bd?context=explore
4. Give the workDIR - host machine path - in this example '/usr/src/app'
5. Copy local files to host machine path '/usr/src/app' 
6. Run the command mvn test with keyword 'CMD mvn test'

7.Build the docker image and run the container

8. Command to build the docker Image without quotes: 'docker build -t karatedockertest .'

    here karatedockertest is the name of the image
9. Once you build the docker images, it will list in desktop docker app - under images
10. Run the docker image : 'docker run -it karatedockertest'   
    There is no cache, it runs in isolated env always. so dependencies will be downloaded everytime we run

'''

Dockerfile without Compose

FROM maven:3.6.3-jdk-11

WORKDIR /usr/src/app

COPY pom.xml /usr/src/app
COPY ./src/test/java /usr/src/app/src/test/java

CMD mvn test
'''


------------

Docker Compose (Efficient Way)
Need for Docker Compose:
1. Docker results are stored in container and not in local 
2. Everytime dependencies are downloaded 

Inside 'docker-compose.yml' file 

1. version is docker compose version , 3.8 being latest now
2. services:
        karate-tests: (Name the service)
        image: karate-tests (name the image)
        build: 
            context: . (build under root directory)
            dockerfile: ./Dockerfile  (path of dockerfile inside root directory)
        volumes:  (Mapping)
             - ./target: /usr/src/app/target   (left side host machine, rt side container, copy from host to local mapping so results can be accessed)
             -   ~ /.m2 : /root/.m2  (checks cache first and downloads only new dependency, first checks our local machine)
        command: mvn test (remove from Dockerfile and add it here)

Build Docker Compose: 
      
      docker-compose up --build 


File:  docker-compose.yml 

version: "3.8"
services: 
    karate-tests:
        image: karate-tests
        build: 
            context: .
            dockerfile: ./Dockerfile
        volumes: 
            - ./target:/usr/src/app/target
            - ~ /.m2:/root/.m2
        command: mvn test

Remove mvn test command from Dockerfile when we include compose.


-----------------------

Performance Testing Using Gatling: 

Gatling uses Scala, Karate and Gatling goes well. We can use same feature file to execute it. 

Lets see the basic example. Refer: https://github.com/intuit/karate/tree/master/karate-gatling

1. Add Dependency and Plugin 
2. Plugin, config the performance folder, change the version 
3. Create a data folder - for test data used for Simulation - is where Gatling look for testdata 

Command to run: mvn clean test-compile gatling:test

If we run this, we will get this error: -->  No simulations to run 

4. Create a feature file for Perfomance, copy paste any of feature
5. Create a Scala file for Simulation. What is simulation, eg.: loading virtual users to the service, eg. if create is 1 request, we can simulate with 4, 5 or anyusers for that matter
6. Create a scala file, copy paste the content from Usage in same link and edit it
7.   setUp() - is the function 
default example:  create.inject(rampUsers(10) during (5 seconds)).protocols(protocol)

8. Run the command again, after updating the scala file and re-run

Scala File after changing: 

package aut

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol()

  //protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val createArticle = scenario("Create Article").exec(karateFeature("classpath:aut/perfomance/CreateArticlePerfomance.feature"))

  setUp(
    createArticle.inject(atOnceUsers(1)).protocols(protocol)
  )

}


9. The reports will be present inside target/gatling

10. Change the config the atOnceUsers(3) - so 3 virtuals users will be loaded, check the service calls in the reports after changing the config



---------
Feeders from file, passes dynamic data to virtual users gatling is creating

__gatling  - will have gatling session object

Feeder file / test data file is csv file


Stratergies -> to make sure the logic on how to use the testdata by Gatling for our test





-------

Name Resolver: Change the title in the Gatling Report

karate-name is the keyword

-------

Increase the thread pool size for dispatcher for parallel configurations


------

Change the logback.xml - Debug to Info for minimum logs or to avoid JVM error 

