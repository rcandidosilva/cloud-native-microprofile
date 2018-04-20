package demo.microservicesconference.rest;

import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@ApplicationScoped
public class SessionService {

    @Inject
    SpeakerClient client;

    List<Session> sessions;

    @PostConstruct
    public void init() {
        sessions = Arrays.asList(new Session(1, "Cloud Native Java EE", "Intermediatte", Arrays.asList(1, 2)));
    }

    public List<Session> getSessions() throws Exception {
        for (Session session : sessions) {
            List<Speaker> speakers = new ArrayList<>();
            for (Integer id : session.getSpeakerIds()) {
                Speaker speaker = client.getSpeaker(id);
                if (speaker != null) {
                    speakers.add(speaker);
                }
            }
            session.setSpeakers(speakers);
        }
        return sessions;
    }



}
