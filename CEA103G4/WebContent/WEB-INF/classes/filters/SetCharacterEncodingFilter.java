package filters;

import java.io.*;
import javax.servlet.*;

public class SetCharacterEncodingFilter implements Filter {

	protected String encoding = null;
	protected FilterConfig config = null;

	@Override
	public void init(FilterConfig config) throws ServletException {
		this.config = config;
		this.encoding = config.getInitParameter("encoding");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {


		request.setCharacterEncoding(encoding);

		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		this.encoding = null;
		this.config = null;

	}

}
