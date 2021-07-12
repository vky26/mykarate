package aut;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

import com.intuit.karate.junit5.Karate;

class TestRunner {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:aut").outputCucumberJson(true)
                .tags()
                //.outputCucumberJson(true)
                .parallel(1);
                System.out.println("-->" + results.getReportDir());
        generateReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
    
    // 
    // void testParallel() {
    //     Results results = Runner.path("classpath:aut").tags().parallel(5);
    //     generateReport("target/cucumber-html-reports");
    //     assertEquals(0, results.getFailCount(), results.getErrorMessages());
    // }

    // @Karate.Test
    // Karate testUsers() {
    //     return Karate.run().relativeTo(getClass());
    // }  

    public static void generateReport(String karateOutputPath) {        
        System.out.println("--> karateOutputPath" + karateOutputPath);
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
       
        List<String> jsonPaths = new ArrayList(jsonFiles.size());
        System.out.println("--> jsonFiles" + jsonFiles.size());

        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "AUT");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();        
    }

    

}
