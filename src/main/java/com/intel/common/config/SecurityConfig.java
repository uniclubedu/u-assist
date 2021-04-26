/*******************************************************************************
 * // Copyright (c) 2021 Intel Corporation
 * //
 * // Licensed under the Apache License, Version 2.0 (the "License");
 * // you may not use this file except in compliance with the License.
 * // You may obtain a copy of the License at
 * //
 * //      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * //
 * // Unless required by applicable law or agreed to in writing, software
 * // distributed under the License is distributed on an "AS IS" BASIS,
 * // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * // See the License for the specific language governing permissions and
 * // limitations under the License.
 ******************************************************************************/
package com.intel.common.config;

import com.intel.common.jwt.JwtAuthenticationFilter;
import com.intel.common.jwt.JwtAuthenticationProvider;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

/**
 * @author sharmatx
 * security class for both JWT and SAML
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    /**
     * Rest security configuration for /api/
     */
    @Configuration
    @Order(1)
    public static class RestApiSecurityConfig extends WebSecurityConfigurerAdapter {

        private static final String API_MATCHER = "/api/**";

        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http = http.cors().and().csrf().disable();

            // Set permissions on endpoints
            http.authorizeRequests()
                // Our public endpoints
                .antMatchers(API_MATCHER).permitAll()
                .antMatchers(HttpMethod.GET, API_MATCHER).permitAll()
                .antMatchers(HttpMethod.POST, API_MATCHER).permitAll()
                .antMatchers(HttpMethod.OPTIONS, API_MATCHER).permitAll();
        	
        	
        	http.addFilterBefore(new JwtAuthenticationFilter(API_MATCHER, super.authenticationManager()), UsernamePasswordAuthenticationFilter.class);

        	http.antMatcher(API_MATCHER).authorizeRequests()
                    .anyRequest()
                    .authenticated();
                    
        }

        @Override
        protected void configure(AuthenticationManagerBuilder auth) throws Exception {
            auth.authenticationProvider(new JwtAuthenticationProvider());
        }
        
        @Bean
        public CorsFilter corsFilter() {
            UrlBasedCorsConfigurationSource source =
                new UrlBasedCorsConfigurationSource();
            CorsConfiguration config = new CorsConfiguration();
            config.setAllowCredentials(true);
            config.addAllowedOrigin("*");
            config.addAllowedHeader("*");
            config.addAllowedMethod("*");
            source.registerCorsConfiguration("/**", config);
            return new CorsFilter(source);
        }
    }

}
