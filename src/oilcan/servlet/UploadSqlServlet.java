package oilcan.servlet;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oilcan.service.OilcanService;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.RequestContext;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.servlet.ServletRequestContext;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import util.FileUtil;
import util.StringUtil;

public class UploadSqlServlet extends HttpServlet {

	private static final long serialVersionUID = -11877173217322L;
	
	final static Log logger = LogFactory.getLog(UploadSqlServlet.class);


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 设置上传路径
		String uploadPath = this.getServletContext().getRealPath("/") + "importFiles";
		// 创建文件夹
		FileUtil.createFolder(uploadPath);
		// 执行完成后跳转路径
		String returnPath = "";
		// 文件名
		String fileName = "";
		
		try{   
			request.setCharacterEncoding("UTF-8");
			// 判断是否包含 multipart 内容
			RequestContext requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){
				DiskFileItemFactory factory = new DiskFileItemFactory();
				// 设置缓冲大小 ,设为1Mb 
	            factory.setSizeThreshold(1024 * 1024);
	            // 设置文件的缓存路径
	            factory.setRepository(new File("C:/Windows/Temp"));
	            // 创建上传处理 
	            ServletFileUpload upload = new ServletFileUpload(factory);
	            // 解析所有表单项
				List items = upload.parseRequest(requestContext);
				
				// 从表单项中提取属性
				for (Object obj:items){
					FileItem item = (FileItem)obj;
					// 获取表单项
					if(item.isFormField()){
						if(item.getFieldName().equals("returnPath"))
							returnPath += item.getString();
					}
				}
				
				// 执行文件上传写入
				for (Object obj:items){
					FileItem item = (FileItem)obj;
					// 如果item不为表单项时，为上传内容
					if(!item.isFormField()){
						// 真实文件名
						fileName = FilenameUtils.getName(item.getName());
						// 文件上传路径
						String fileUploadPath = uploadPath + File.separator + fileName;
						if(StringUtil.isEmpty(fileName) || item.getSize() == 0)
							throw new ServletException("文件导入失败：文件名为空或者文件大小为0！");
						// 写入文件
						item.write(new File(fileUploadPath));
					}
				}
				
				WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());  
				OilcanService service = (OilcanService) context.getBean("oilcanService");  
				int state = service.insertSql(uploadPath + File.separator + fileName);
				if(state == 1)
					request.setAttribute("returnText", "数据导入成功!");
				else
					request.setAttribute("returnText", "数据导入失败!");
			}
		}catch (Exception e){
			request.setAttribute("returnText", e.getMessage());
			logger.error(e.getMessage(), e);
		}finally{
			//删除上传的文件
			try {
				File file = new File(uploadPath + File.separator + fileName);  
				file.delete();
				request.getRequestDispatcher(returnPath).forward(request, response);
			} catch (Exception e) {
				logger.error(e.getMessage(), e);
			}
		} 
	}

}
