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
package com.intel.common.jwt;

import com.intel.common.util.JwtTokenUtil;
import com.nimbusds.jwt.SignedJWT;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.util.Assert;

import java.text.ParseException;
import java.time.LocalDateTime;
import java.time.ZoneId;

/**
 * @author sharmatx
 */
public class JwtAuthenticationProvider implements AuthenticationProvider {

	@Override
	public boolean supports(Class<?> authentication) {
		return JwtAuthenticationToken.class.isAssignableFrom(authentication);
	}

	@Override
	public Authentication authenticate(Authentication authentication) {

		Assert.notNull(authentication, "Authentication is missing");

		Assert.isInstanceOf(JwtAuthenticationToken.class, authentication,
				"This method only accepts JwtAuthenticationToken");

		String jwtToken = authentication.getName();

		if (authentication.getPrincipal() == null || jwtToken == null) {
			throw new AuthenticationCredentialsNotFoundException("Authentication token is missing");
		}

		boolean isVerified = JwtTokenUtil.validateToken(jwtToken);
		final SignedJWT signedJWT;
		try {
			signedJWT = SignedJWT.parse(jwtToken);

			//boolean isVerified = signedJWT.verify(SecurityConstant.JWT_SECRET.getBytes());

			if (!isVerified) {
				throw new BadCredentialsException("Invalid token signature");
			}

			// is token expired ?
			LocalDateTime expirationTime = LocalDateTime
					.ofInstant(signedJWT.getJWTClaimsSet().getExpirationTime().toInstant(), ZoneId.systemDefault());

			if (LocalDateTime.now(ZoneId.systemDefault()).isAfter(expirationTime)) {
				throw new CredentialsExpiredException("Token expired");
			}

			return new JwtAuthenticationToken(signedJWT, null, null);

		} catch (ParseException e) {
			throw new InternalAuthenticationServiceException("Unreadable token");
		}
	}
}