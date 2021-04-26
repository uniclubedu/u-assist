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
package com.intel.common.util;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import com.google.gson.Gson;
import com.intel.common.constant.SecurityConstants;
import com.intel.common.request.Access;
import com.intel.common.request.JwtParser;
import com.nimbusds.jwt.SignedJWT;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import net.minidev.json.JSONObject;

/**
 * Utility class for handling jwt token
 *
 */
@Component
public class JwtTokenUtil implements Serializable {

    private static final long serialVersionUID = -2550185165626007488L;

    public static final long JWT_TOKEN_VALIDITY = 5 * 60 * 60;

    // retrieve username from jwt token
    public static String getUsernameFromToken(String token) {
        return getClaimFromToken(token, Claims::getSubject);
    }

    // retrieve expiration date from jwt token
    public static Date getExpirationDateFromToken(String token) {
        return getClaimFromToken(token, Claims::getExpiration);
    }

    public static <T> T getClaimFromToken(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = getAllClaimsFromToken(token);
        return claimsResolver.apply(claims);
    }

    // for retrieving any information from token we will need the secret key
    public static Claims getAllClaimsFromToken(String token) {
        return Jwts.parser().setSigningKey(SecurityConstants.JWT_SECRET).parseClaimsJws(token).getBody();
    }

    // check if the token has expired
    private static Boolean isTokenExpired(String token) {
        final Date expiration = getExpirationDateFromToken(token);
        return expiration.before(new Date());
    }

    public static JwtParser parseJwtToObject(SignedJWT sjwt) {
        JSONObject obj = sjwt.getPayload().toJSONObject();
        Gson gson = new Gson();
        return gson.fromJson(obj.toJSONString(), JwtParser.class);

    }

    // generate token for user
    public static String generateToken(JwtParser user) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("userId", user.getUserId());
        claims.put("userName", user.getUserName());
        claims.put("access", user.getAccess());
        claims.put("accountExpiry", user.getAccountExpiry());
        claims.put("daysLeft", user.getDaysLeft());
        return doGenerateToken(claims, user.getUserName().trim());
    }

    // validate token
    public static Boolean validateToken(String token) {
        return (!isTokenExpired(token));
    }

    public static String doGenerateToken(Map<String, Object> claims, String subject) {
        return Jwts.builder().setClaims(claims).setSubject(subject).setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + JwtTokenUtil.JWT_TOKEN_VALIDITY * 1000))
                .signWith(SignatureAlgorithm.HS512, SecurityConstants.JWT_SECRET).compact();
    }

    public static Collection<? extends GrantedAuthority> getAuthorities(SignedJWT sjwt) {
        JwtParser jwtParser = parseJwtToObject(sjwt);
        Access[] access = jwtParser.getAccess();
        List<GrantedAuthority> authorities = new ArrayList<>();
        for (Access acs : access) {
            authorities.add(new SimpleGrantedAuthority(acs.getRole().trim()));
        }
        return authorities;
    }
}
