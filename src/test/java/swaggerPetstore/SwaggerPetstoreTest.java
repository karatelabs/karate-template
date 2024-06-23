package swaggerPetstore;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class SwaggerPetstoreTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:swaggerPetstore")
                //.outputCucumberJson(true)
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
