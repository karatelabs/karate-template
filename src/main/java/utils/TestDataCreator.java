package utils;

import com.github.javafaker.Faker;

public class TestDataCreator {

    private static Faker faker = new Faker();

    public static String getDogName() {
        /**
         * Returns a dog name
         */
        return faker.dog().name();
    }

    public static String getDogCategoryName() {
        /**
         * Returns a dog category name
         */
        return faker.dog().breed();
    }

    public static int getDogAge() {
        /**
         * Returns a dog age
         */
        return Integer.parseInt(faker.dog().age());

    }

    public static int getID() {
        /**
         * Returns an ID value as an integer
         */
        return faker.number().numberBetween(0,10000);
    }

    public static String getCatName() {
        /**
         * Returns a cat name
         */
        return faker.cat().name();
    }

    public static String getCatCategoryName() {
        /**
         * Returns a cat category name
         */
        return faker.cat().breed();
    }

    public static String getFileName() {
        /**
         * Returns a file name
         */
        return faker.file().fileName();
    }


    public static String[] getStatus() {
        /**
         * Returns a status
         */
        return new String[]{"available", "pending", "sold"};
    }
}
