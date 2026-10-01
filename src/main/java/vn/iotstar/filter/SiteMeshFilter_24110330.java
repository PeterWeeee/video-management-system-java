package vn.iotstar.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;

@WebFilter(filterName = "sitemeshFilter", urlPatterns = "/*")
public class SiteMeshFilter_24110330 implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo Decorator Filter
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // Cho phép request/response đi qua an toàn trên Tomcat 10/11, tránh lỗi trắng trang
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
