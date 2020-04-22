import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.output.Slf4jLogConsumer;
import org.testcontainers.containers.wait.strategy.Wait;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

public abstract class ContainerTestBase {
    private static final Logger logger = LoggerFactory.getLogger(ContainerTestBase.class);

    private static GenericContainer _container;

    @BeforeClass
    public static void setUp() throws IOException {
        String dockerImageTag = System.getProperty("image_tag");

        logger.info("Tested Docker image tag: {}", dockerImageTag);

        clearExporterCache();

        _container = new GenericContainer<>(dockerImageTag)
                .withFileSystemBind(getExamplesPath(), "/docs")
                .waitingFor(Wait.forLogMessage("(.*)Serving on http://0\\.0\\.0\\.0:8000(.*)", 1));

        _container.start();
        _container.followOutput(new Slf4jLogConsumer(logger));
    }

    @AfterClass
    public static void cleanUp() {
        _container.stop();
        _container.close();
    }

    protected GenericContainer getContainer() {
        return _container;
    }

    protected static String getExamplesPath() {
        Path result = Paths.get(System.getProperty("user.dir"), "../example").normalize();

        System.out.println("PATH=" + result.toString());

        return result.toString();
    }

    protected static Path getExporterCachePath() {
        return Paths.get(getExamplesPath(), "docs", "drawio-exporter");
    }

    protected static void clearExporterCache() throws IOException {
        File directory = new File(getExporterCachePath().toString());

        if(!directory.exists()) {
            return;
        }

        File[] allContents = directory.listFiles();
        if (allContents != null) {
            for (File file : allContents) {
                file.delete();
            }
        }

        directory.delete();
    }
}