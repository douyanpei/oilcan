package report.api;

import java.io.IOException;
import java.io.OutputStream;
import java.io.StringWriter;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;
import org.w3c.dom.Document;

import web.WebScope;
import web.WebSupport;

public abstract class AbstractXmlReport extends WebSupport implements Reportable {
	private static final long serialVersionUID = -8275650288715434087L;

	protected String xml;
	protected String xsl;
	
	public AbstractXmlReport() {
	}

	public AbstractXmlReport(String xml, String xsl, WebScope webScope) {
		super(webScope);
		this.xml = xml;
		this.xsl = xsl;
	}

	public String getXml() {
		return xml;
	}

	public void setXml(String xml) {
		this.xml = xml;
	}

	public String getXsl() {
		return xsl;
	}

	public void setXsl(String xsl) {
		this.xsl = xsl;
	}

	//Hook
	protected abstract void buildXmlDocument(Map args, Document xmlDoc) throws Exception;
	
	@Override
	public String report(Map args) throws Exception {  
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document xmlDoc = null;
		if (xml!=null) {
			xmlDoc = builder.parse(getFile(xml));
		} else {
			xmlDoc = builder.newDocument();
		}
		buildXmlDocument(args, xmlDoc);
		return transform(xmlDoc);
	}

	protected String transform(Document xmlDoc) throws Exception {
		if (xsl!=null) {
            Source xslSource = new StreamSource(getFile(xsl));
	        Source xmlSource = new DOMSource(xmlDoc);
	        TransformerFactory transformerFactory = TransformerFactory.newInstance();
	        Transformer transformer = transformerFactory.newTransformer(xslSource);
	        StringWriter output = new StringWriter();
	        Result result = new StreamResult(output);
	        transformer.transform(xmlSource, result);
	        System.out.println(output.toString());
	        return output.toString();
		} else {
			return "";
		}
	}
	
	protected void printXML(Document xmlDoc, OutputStream os) throws IOException {
		OutputFormat f = new OutputFormat(xmlDoc);
		f.setEncoding("gb2312");
		f.setIndenting(true);
		f.setIndent(3);
		f.setLineSeparator("\n");
		XMLSerializer s = new XMLSerializer(os, f);
		s.serialize(xmlDoc);
	}

}
