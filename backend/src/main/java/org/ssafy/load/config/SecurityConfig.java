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
        filterRegistrationBean.addUrlPatterns("/worker/ready");
        filterRegistrationBean.addUrlPatterns("/car/*");
        filterRegistrationBean.addUrlPatterns("/goods/*");
        filterRegistrationBean.addUrlPatterns("/path");
        filterRegistrationBean.addUrlPatterns("/admin/good-counts");
        filterRegistrationBean.addUrlPatterns("/admin/settings");
        filterRegistrationBean.addUrlPatterns("/admin/racks");
        filterRegistrationBean.addUrlPatterns("/admin/day-counts");
        filterRegistrationBean.addUrlPatterns("/admin/goods");
        filterRegistrationBean.addUrlPatterns("/admin/types");
        filterRegistrationBean.addUrlPatterns("/admin/workers");
        filterRegistrationBean.addUrlPatterns("/admin/loads");
        filterRegistrationBean.addUrlPatterns("/admin/area");
        return filterRegistrationBean;
    }
}