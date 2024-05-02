package org.ssafy.load.config;

import jakarta.servlet.Filter;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.ssafy.load.security.JwtFilter;
import org.ssafy.load.security.JwtTokenProvider;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    @Bean
    public FilterRegistrationBean<Filter> loginFilter() {
        FilterRegistrationBean<Filter> filterRegistrationBean = new FilterRegistrationBean<>();
        filterRegistrationBean.setFilter(new JwtFilter());
        filterRegistrationBean.setOrder(1);
//        filterRegistrationBean.addUrlPatterns("/worker/*");
        return filterRegistrationBean;
    }
//    public SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
//        return httpSecurity
//            // HTTP Basic 인증 비활성화
//            .httpBasic(httpBasic -> httpBasic.disable())
//            .csrf(csrf -> csrf.disable())
//            // 세션 정책 설정
//            .sessionManagement(sessionManagement ->
//                sessionManagement.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
//            .authorizeHttpRequests(auth -> auth
//                .requestMatchers("/worker/**").permitAll()
//                .requestMatchers("/simulation/**").permitAll()
//                .requestMatchers("/members/test").hasRole("USER")
//                .anyRequest().authenticated())
//            .addFilterBefore(new JwtFilter(),
//                UsernamePasswordAuthenticationFilter.class)
//            .build();
//    }
}