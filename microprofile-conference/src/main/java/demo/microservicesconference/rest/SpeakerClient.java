package demo.microservicesconference.rest;

import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.faulttolerance.Fallback;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.client.ClientBuilder;
import java.net.URI;

@ApplicationScoped
public class SpeakerClient {

    @Inject
    @ConfigProperty(name = "SPEAKER_SERVICE", defaultValue = "http://localhost:8080/speakers")
    String speakerService;

    @Fallback(fallbackMethod = "getSpeakerFallback")
    public Speaker getSpeaker(Integer id) throws Exception {
        return ClientBuilder.newClient().target(new URI(speakerService + "/" + id)).request().get(Speaker.class);
    }

    public Speaker getSpeakerFallback(Integer id) {
        return null;
    }

}
