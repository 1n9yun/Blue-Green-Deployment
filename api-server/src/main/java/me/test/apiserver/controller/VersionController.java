package me.test.apiserver.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class VersionController {

    @Value("${my-server.property.version}")
    private Integer serverVersion;

    @GetMapping("/ver")
    public int getVersion(){
        return this.serverVersion;
    }

}
