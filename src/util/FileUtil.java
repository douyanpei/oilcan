package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.Random;

public class FileUtil {
	
	public static String getWebInfoPath() throws UnsupportedEncodingException{
		String path = URLDecoder.decode(Thread.currentThread().getContextClassLoader().getResource("")+"", "utf-8") ;
		if(path != null && !path.equals("")){
			if(path.indexOf("file:/") != -1){
				path = path.substring(path.indexOf("file:/")+6,path.length());
			}
			if(path.indexOf("WEB-INF/") != -1){
				path = path.substring(0,path.lastIndexOf("WEB-INF/") + 8);
			}
		    if("/".equals(File.separator)){   
		    	path  = path.substring(0,path.indexOf("/WEB-INF/classes"));
		    	path = path.replace("\\", "/");
		    }
		}
		return path;
	}
	
	/** 创建空白文件
	 * @param fileName 文件
	 * @param dir 保存文件的目录
	 * @return
	 */
	private static File createNewFile(String fileName,String dir)
	{ 
		File dirs = new File(dir);
		//看文件夹是否存在，如果不存在新建目录
		if(!dirs.exists())
			dirs.mkdirs(); 
		//拼凑文件完成路径
		File file = new File(dir+File.separator+fileName);
		try 
		{ 
			//判断是否有同名名字，如果有同名文件加随机数改变文件名
			while(file.exists())
			{
				int ran = getRandomNumber();
				String prefix = getFileNamePrefix(fileName);
				String suffix = getFileNameSuffix(fileName);
				String name = prefix+ran+"."+suffix;
				file = new File(dir+File.separator+name);
			} 
			file.createNewFile();
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		return file;
	}
	
	/** 
	 * 创建文件夹，如果文件夹存在则不进行创建
	 * @param path 
	 * @throws Exception  
	 */  
	public static void createFolder(String path) {
		try {  
			path = separatorReplace(path);  
			File folder = new File(path);  
			if(folder.isDirectory() && folder.exists())
				return;  
			folder.mkdirs();  
		}catch(Exception e){
			e.printStackTrace();
		}
	}  
	
	/*** 获得随机数
	 * @return
	 */
	private static int getRandomNumber() 
	{
		Random random = new Random(new Date().getTime()); 
		return Math.abs(random.nextInt());
	}
	
	/*** 分割文件名 如a.txt 返回 a
	 * @param fileName 
	 * @return
	 */
	public static String getFileNamePrefix(String fileName)
	{
		int dot = fileName.lastIndexOf(".");
		return fileName.substring(0,dot);
	}

	
	/**
	 * 从文件路径中获取文件名
	 * @param fullName
	 * @return
	 */
	public static String getFileName(String fullName) 
	{
	   return fullName==null? "" : fullName.substring(fullName.lastIndexOf("\\") + 1, fullName.length());
	}
	
	/*** 获得文件后缀
	 * @param fileName
	 * @return
	 */
	public static String getFileNameSuffix(String fileName) 
	{
		int dot = fileName.lastIndexOf("."); 
		return fileName.substring(dot+1);
	}
	
    /** 
	 * 将源文件的数据写入到目标文件中， 
	 * 不会检查源文件是否存在， 
	 * 若目标文件存在则直接写入， 
	 * 否则创建目标文件后再进行写入。 
	 * @param srcPath 
	 * @param desPath 
	 */  
	private static void copyFile(String srcPath,String desPath){  
	    try {  
	        FileInputStream in = new FileInputStream(srcPath);  
	        FileOutputStream out = new FileOutputStream(desPath);  
	        byte[] bt = new byte[1024];  
	        int count;  
	        while ((count = in.read(bt)) > 0) {  
	            out.write(bt, 0, count);  
	        }  
	        in.close();  
	        out.close();   
	    } catch (IOException ex) {  
	        ex.printStackTrace();  
	    }         
	}  
	
	/** 
	 * 复制文件，若文件存在则替换该文件
	 * @param srcPath 
	 * @param desPath 
	 * @throws Exception 
	 */  
	public static void copyAndReplaceFile(String srcPath,String desPath) throws RuntimeException{  
	    srcPath = separatorReplace(srcPath);  
	    desPath = separatorReplace(desPath);  
	    File srcFile = new File(srcPath);  
	    if(!srcFile.isFile()){  
	       throw new RuntimeException("源文件没有找到!");  
	    }  
	    copyFile(srcPath,desPath);  
	}  
	      
	/** 
	 * 复制文件，若文件已存在则不进行替换
	 * @param srcPath 
	 * @param desPath 
	 * @throws Exception 
	 */  
	public static void copyAndNotReplaceFile(String srcPath,String desPath) throws RuntimeException{  
	    File srcFile = new File(separatorReplace(srcPath));  
	    File desFile = new File(separatorReplace(desPath));  
	    if(!srcFile.isFile()){  
	       throw new RuntimeException("源文件没有找到!");  
	    }  
	    if(desFile.isFile()){  
	       return;  
	    }  
	    copyFile(srcPath,desPath);  
	}  
	
	/** 
	 * 分隔符替换
	 * @param path 
	 * @return 
	 */  
	public static String separatorReplace(String path){  
	    return path.replace("\\",File.separator).replace("//", File.separator);  
	}  
	
	/** 
	 * 根据文件路径删除文件，如果路径指向的文件不存在或删除失败则抛出异常
	 * @param path 
	 * @return 
	 * @throws Exception  
	 */  
	public static void deleteFile(String path) throws Exception {  
	    File file = getFile(path);      
	    if(file.exists()) {
	    	if(!file.delete())
	    		throw new RuntimeException("删除文件失败！");  
	    } else {
	    	throw new RuntimeException("错误原因：没有找到这个文件！");  
	    }
	}  
	 
	/** 
	 * 根据路径删除文件夹，如果路径指向的目录不存在则抛出异常， 
	 * 若存在则先遍历删除子项目后再删除文件夹本身
	 * @param path 
	 * @throws Exception  
	 */  
	public static void deleteFolder(String path) throws Exception {  
	    File folder = getFile(path);  
	    File[] files = folder.listFiles();   
	    for(File file:files) {                  
	       if(file.isDirectory()){  
	    	   deleteFolder(file.getAbsolutePath());  
           }else if(file.isFile()){                     
        	   deleteFile(file.getAbsolutePath());                                   
	       }  
	    }    
	    folder.delete();   
	}  
	 
	/** 
	 * 根据文件路径，获得该路径指向的文件的大小
	 * @param path 
	 * @return 
	 * @throws FileNotFoundException 
	 */  
	 public static long getFileSize(String path) throws FileNotFoundException{  
		 File file = getFile(path);  
		 return file.length();  
	} 
	 
	/** 
	 * 通过路径获得文件
	 * 若不存在则抛异常
	 * 若存在则返回该文件 
	 * @param path 
	 * @return 
	 * @throws FileNotFoundException 
	 */  
	public static File getFile(String path) {  
		path = separatorReplace(path);                
	 	return new File(path);  
	 }  
	
	/**
	 * 获取文件列表，并排序，文件夹在前，文件在后
	 * @throws FileNotFoundException 
	 */
	public static String[] getFileListByType(final String path) {
		File folder = getFile(path);  
		//文件列表
		String[] files = folder.list();  
		if (files != null)
		{
			//文件排序,文件夹在前，文件在后
			Arrays.sort(files, new Comparator<Object>() {  
				@Override  
				public int compare(Object arg1, Object arg2) {  
					File file1 = new File(path + File.separator + String.valueOf(arg1));  
					File file2 = new File(path + File.separator + String.valueOf(arg2));  
					if(file1.isFile() && file2.isDirectory())
						return 1;  
					else if(file2.isFile() && file1.isDirectory())
						return -1;  
					else
						return file1.getName().compareTo(file2.getName());
				}  
			});
		}
		return files;
	}
}
