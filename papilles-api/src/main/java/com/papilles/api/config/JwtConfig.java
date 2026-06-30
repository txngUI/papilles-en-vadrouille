package com.papilles.api.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "papilles.jwt")
@Getter
@Setter
public class JwtConfig {

    // mappe papilles.jwt.secret
    private String secret;

    // mappe papilles.jwt.expiration (1h par défaut)
    private long expiration = 3_600_000L;

    // mappe papilles.jwt.refresh-expiration (7j par défaut)
    private long refreshExpiration = 604_800_000L;
}
