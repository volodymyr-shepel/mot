package com.mot.security;

import com.mot.util.JwtUtilOrder;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class JwtTokenFilterOrderService extends OncePerRequestFilter {

    private final JwtUtilOrder jwtUtilOrder;


    @Autowired
    public JwtTokenFilterOrderService(JwtUtilOrder jwtUtilOrder) {
        this.jwtUtilOrder = jwtUtilOrder;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        final String authHeader = request.getHeader("Authorization");

        // if there is no auth header or header does not start with bearer -> proceed to the next filter
        if (authHeader == null ||!authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }
        String accessToken = JwtUtilOrder.extractAuthToken(authHeader);

        // if there is no token proceed to the next filter and do not set SecurityContextHolder in this filter
        if(accessToken == null || accessToken.isEmpty()){
            filterChain.doFilter(request,response);
            return;
        }

        // if the token validation fails go to the next filter and do not set SecurityContextHolder in this filter
        if(!jwtUtilOrder.validateToken(accessToken)){
            filterChain.doFilter(request,response);
            return;
        }


        setAuthenticationContext(accessToken,request);


        filterChain.doFilter(request,response);
    }

    private void setAuthenticationContext(String token, HttpServletRequest request) {
        final String userEmail = jwtUtilOrder.extractUsername(token);

        UsernamePasswordAuthenticationToken
                authentication = new UsernamePasswordAuthenticationToken(userEmail, null, jwtUtilOrder.extractAuthoritiesFromToken(token));

        authentication.setDetails(
                new WebAuthenticationDetailsSource().buildDetails(request));

        SecurityContextHolder.getContext().setAuthentication(authentication);

    }




}
