package aut

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol()

  //protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val createArticle = scenario("Create Article").exec(karateFeature("classpath:aut/perfomance/CreateArticlePerfomance.feature"))

  setUp(
    createArticle.inject(atOnceUsers(3)).protocols(protocol)
  )

}