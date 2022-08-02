package com.dy.traveller.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SpringSecurity {

	@Bean
	public BCryptPasswordEncoder bcryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public SecurityFilterChain authenticatePath(HttpSecurity http) throws Exception {//본 method가 반환할 SecurityFilterChain을 bean으로 등록하겠다는 의미
	//HttpSecurity객체로는, legacy에서 spring-context.xml파일의 <security:http>태그 아래 수행했던 설정 작업들을 할 수 있음!
	//SecurityFilterChain 역할 : 권한 확인 및 처리
	
		//해당 객체는 builder패턴 방식으로 초기화함
		return http.csrf().disable() //login時, 별다른 key값 등을 보내지 않을 것이므로 disable (+추가 필기 : csrf토큰이 없어도 요청을 받아들일 수 있도록 설정함)
						 .formLogin() //○ 로그인 관련 설정 시작 ~ ()로그인 폼 등록 : 로그인 페이지, 파라미터 등을 설정함
						 .disable()
						 .headers().frameOptions().disable().and().build();
		
	}
	

}
