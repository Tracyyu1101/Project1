package tracy;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * class DataStoreServlet:
 * for creating and store tweets
 */
@WebServlet("/indexServlet")
public class DataStoreServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ----------------------------------------------------------
	/**
	 * for creating a new tweet in Datastore
	 * @param req Request
	 * @param resp Response
	 *
	 * @throws IOException
	 * @throws ServletException
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.getWriter().append("Served at: ").append(req.getContextPath());
	}

}
