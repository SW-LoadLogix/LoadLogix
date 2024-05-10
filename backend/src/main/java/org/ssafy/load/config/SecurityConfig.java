package org.ssafy.load.config;

import jakarta.servlet.Filter;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.ssafy.load.security.JwtFilter;
import org.ssafy.load.security.JwtTokenProvider;

@Configuration
@RequiredArgsConstructor
public class SecurityConfig {

    private final JwtTokenProvider jwtTokenProvider;

    @Bean
    public FilterRegistrationBean<Filter> loginFilter() {
        FilterRegistrationBean<Filter> filterRegistrationBean = new FilterRegistrationBean<>();
        filterRegistrationBean.setFilter(new JwtFilter(jwtTokenProvider));
        filterRegistrationBean.setOrder(1);
        filterRegistrationBean.addUrlPatterns("/worker/info");
//        filterRegistrationBean.addUrlPatterns("/worker/ready");
//        filterRegistrationBean.addUrlPatterns("/goods/*");
//        filterRegistrationBean.addUrlPatterns("/car/*");
        //filterRegistrationBean.addUrlPatterns("/*");
        return filterRegistrationBean;
    }
}