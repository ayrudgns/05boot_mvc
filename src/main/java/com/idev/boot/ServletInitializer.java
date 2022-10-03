package com.idev.boot;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

// Spring Boot의 기본 view 템플릿 엔진(.html)을 사용하지 않고 .jsp를 사용하기 위해 필요한 설정을 초기화함. (서블릿 초기화)
public class ServletInitializer extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(Application.class);
	}
// 서블릿 : 웹 애플리케이션의 html 문서를 java로 작성 -> .class 컴파일한 결과로 html이 만들어진다. (.jsp)
// 즉, java -> .java -> .class -> html 문서 생성
}
