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
public class SecurityConfigurationOrderService {



    private final JwtTokenFilterOrderService jwtTokenFilterOrderService;

    private final JwtAuthenticationEntryPointOrderService jwtAuthenticationEntryPointOrderService;

    @Autowired
    public SecurityConfigurationOrderService(JwtTokenFilterOrderService jwtTokenFilterOrderService,
                                             JwtAuthenticationEntryPointOrderService jwtAuthenticationEntryPointOrderService) {
        this.jwtTokenFilterOrderService = jwtTokenFilterOrderService;
        this.jwtAuthenticationEntryPointOrderService = jwtAuthenticationEntryPointOrderService;
    }

    @Bean
    public SecurityFilterChain securityFilterChainOrderService(HttpSecurity http) throws Exception{
        http.csrf(AbstractHttpConfigurer::disable);
        http
                .authorizeHttpRequests((auth) -> auth
                        .requestMatchers("/api/order/admin/**").hasAuthority(UserRole.ADMIN.name())
                        .requestMatchers("/api/order/customer/**").hasAuthority(UserRole.CUSTOMER.name())
                        .requestMatchers("/api/order/public/**").permitAll()
                        .anyRequest().authenticated()
                )
                .formLogin(AbstractAuthenticationFilterConfigurer::permitAll);
        http.exceptionHandling(e -> e.authenticationEntryPoint(jwtAuthenticationEntryPointOrderService));
        http.sessionManagement(s -> s.sessionCreationPolicy(SessionCreationPolicy.STATELESS));
        http.addFilterBefore(jwtTokenFilterOrderService, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }







}