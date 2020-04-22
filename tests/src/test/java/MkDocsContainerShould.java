import org.junit.Test;

import java.io.File;

import static org.junit.Assert.assertTrue;

public class MkDocsContainerShould extends ContainerTestBase {
    @Test
    public void generateSvg() {
        File cacheDir = new File(getExporterCachePath().toString());
        File[] files = cacheDir.listFiles();

        assertTrue(files.length > 0);
    }
}
