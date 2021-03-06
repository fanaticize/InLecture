package com.team3.inlecture.authentication;

import java.util.Collection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.team3.inlecture.common.logger.LoggerInterceptor;

public class CustomAuthProvider implements AuthenticationProvider {   
	private static final Log logger = LogFactory.getLog(LoggerInterceptor.class);
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
    AuthenticationService authenticationService;


    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String username = authentication.getName();
        String password = (String) authentication.getCredentials();

        Collection<? extends GrantedAuthority> authorities;
        UserAuth user;
        try {
        	 user = authenticationService.loadUserByUsername(username);
            logger.info("username : " + user.getUsername() + " / password : " + user.getPassword()+" / typed password: "+password);

            if (!passwordEncoder.matches(password, user.getPassword()) ) throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
            
            authorities = user.getAuthorities();
        } catch(UsernameNotFoundException e) {
            logger.info(e.toString());
            throw new UsernameNotFoundException(e.getMessage());
        } catch(BadCredentialsException e) {
            logger.info(e.toString());
            throw new BadCredentialsException(e.getMessage());
        } catch(Exception e) {
            logger.info(e.toString());
            throw new RuntimeException(e.getMessage());
        }

        return new UsernamePasswordAuthenticationToken(user, password, authorities);
    }

    @Override
    public boolean supports(Class<?> arg0) {
        return true;
    }

}
