package runners;

import com.intuit.karate.junit5.Karate;

class TestRunner {
    @Karate.Test
    Karate testPetstore() {
        return Karate.run("classpath:features/fraud-detection.feature");
    }
}
