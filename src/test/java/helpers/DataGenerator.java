package helpers;

import java.util.HashMap;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class DataGenerator {
    
    public static String generateEmail(){
        String emailID="";
        Faker faker = new Faker();
        emailID =(faker.name().firstName() + faker.random().nextInt(0, 10) + "@test.com").toLowerCase();
        return emailID;
    }

    public static String generateUserName(){
        String userName="";
        Faker faker = new Faker();
        userName =(faker.name().username()).toLowerCase();
        return userName;
    }

    public static HashMap<String, String> getArticleJSONBody(){
        
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().character();
        String body = faker.gameOfThrones().character();
        
        HashMap<String, String> map = new HashMap<String, String>();
        map.put("title", title);
        map.put("description", description);
        map.put("body", body);

        // JSONObject json = new JSONObject();
        // json.put("title", title);
        // json.put("description", description);
        // json.put("body", body);
        
        return map;
    }
}
