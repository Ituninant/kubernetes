package ru.itanton.client.api;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

/**
 * @author itanton
 */
@RestController
@Slf4j
public class CommonAPI {

    @Value("${my.property}")
    String myProperty;

    @PostConstruct
    void init() {
        log.debug("currentPod = {}", Optional.ofNullable(System.getenv("HOSTNAME")).orElse("Unknown"));
        log.debug("myProperty = {}", myProperty);
    }

    @GetMapping("property")
    public String getMyProperty() {
        return myProperty;
    }

    @GetMapping("currentPod")
    public String currentPod() {
        return Optional.ofNullable(System.getenv("HOSTNAME")).orElse("Unknown");
    }

}
