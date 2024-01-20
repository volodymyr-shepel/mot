package com.mot.service.chain.user;

import com.mot.response.AuthenticationClient;
import com.mot.response.IdentityClient;
import com.mot.service.chain.handler.ChainLink;
import com.mot.service.chain.handler.interfaces.Handle;

import java.util.Map;

public class UserExistenceCheck extends ChainLink {
    private final IdentityClient identityClient;
    private final AuthenticationClient authenticationClient;
    private final String userEmail;

    public UserExistenceCheck(IdentityClient identityClient, AuthenticationClient authenticationClient, String userEmail, Map<String, String> errors) {
        this.identityClient = identityClient;
        this.authenticationClient = authenticationClient;
        this.userEmail = userEmail;
        this.errors = errors;
        this.request = new Handle() {
            @Override
            public boolean isInvalid() {
                return false;
                //return !identityClient.isUserExistByEmail(userEmail);
            }

            @Override
            public String getErrorMessage() {
                return "There is no such user";
            }
        };
    }

//    @Override
//    public void handle() {
//        request.handle().ifPresent(s -> {
//            AppUserDTO appUser = new AppUserDTO(
//                    userEmail,
//                    "Anonym", "Anonym","NotExistentPassword#123", UserRole.CUSTOMER);
//            authClient.signUp(appUser);
//
//
//        });
//        handler.ifPresent(Handler::handle);
//    }
}