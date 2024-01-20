package com.mot.security;


import com.mot.util.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractAuthenticationFilterConfigurer;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfigurationProductService {



    private final JwtTokenFilterProductService jwtTokenFilterProductService;

    private final JwtAuthenticationEntryPointProductService jwtAuthenticationEntryPointProductService;

    @Autowired
    public SecurityConfigurationProductService(JwtTokenFilterProductService jwtTokenFilterProductService,
                                               JwtAuthenticationEntryPointProductService jwtAuthenticationEntryPointProductService) {
        this.jwtTokenFilterProductService = jwtTokenFilterProductService;
        this.jwtAuthenticationEntryPointProductService = jwtAuthenticationEntryPointProductService;
    }

    @Bean
    public SecurityFilterChain securityFilterChainProductService(HttpSecurity http) throws Exception{
        http.csrf(AbstractHttpConfigurer::disable);
        http
                .authorizeHttpRequests((auth) -> auth
                        .requestMatchers("/api/product/admin/**").hasAuthority(UserRole.ADMIN.name())
                        .requestMatchers("/api/product/customer/**").hasAuthority(UserRole.CUSTOMER.name())
                        .requestMatchers("/api/product/products/**").permitAll()
                        .requestMatchers("/api/product/categories/**").permitAll()
                        .requestMatchers("/actuator/health").permitAll() // used to permit health checks
                        .anyRequest().authenticated()
                )
                .formLogin(AbstractAuthenticationFilterConfigurer::permitAll);
        http.exceptionHandling(e -> e.authenticationEntryPoint(jwtAuthenticationEntryPointProductService));
        http.sessionManagement(s -> s.sessionCreationPolicy(SessionCreationPolicy.STATELESS));
        http.addFilterBefore(jwtTokenFilterProductService, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }







}