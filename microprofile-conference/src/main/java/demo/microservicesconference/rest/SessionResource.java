package demo.microservicesconference.rest;

import org.eclipse.microprofile.metrics.annotation.Counted;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import java.util.List;

@Path("/sessions")
public class SessionResource {

    @Inject
    SessionService service;

    @GET
    @Produces("application/json")
    @Counted(name = "getAll", absolute = true, monotonic = true, description = "Number the times requested")
    public List<Session> getAll() throws Exception {
        return service.getSessions();
    }

}