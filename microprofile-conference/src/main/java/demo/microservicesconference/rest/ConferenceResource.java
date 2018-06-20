package demo.microservicesconference.rest;

import org.eclipse.microprofile.config.inject.ConfigProperty;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("/conference")
public class ConferenceResource {

    @Inject
    @ConfigProperty(name = "CONFERENCE_NAME", defaultValue = "Oracle Code")
    String conference;

    @GET
    @Consumes("text/plain")
    public String getConference() {
        return conference;
    }

}
