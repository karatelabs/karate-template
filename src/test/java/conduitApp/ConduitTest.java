package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class ConduitTest {

	/*
	 * @Test void testParallel() { Results results =
	 * Runner.path("classpath:conduitApp") //.outputCucumberJson(true) .parallel(5);
	 * assertEquals(0, results.getFailCount(), results.getErrorMessages()); }
	 */
	/*
	 * @Karate.Test Karate testTags() { return Karate.run().relativeTo(getClass());
	 * }
	 */
    
    @Test
    void testParallel() {
        Results results = Runner.path("classpath:conduitApp").tags("@CoderTest").parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
    
}
