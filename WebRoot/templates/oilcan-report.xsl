<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="gb2312"/>
	<xsl:template match="/">
		<xsl:apply-templates />
		<script language="javascript">
			<![CDATA[
				function print() {
					var Word = new ActiveXObject("Word.Application");//
					Word.Application.Visible = true;  //Wordͨ��Application�ɼ�
					Word.documents.add();  //�½��ĵ�
					Word.Selection.PageSetup.LeftMargin = Word.Application.CentimetersToPoints(1.3);  //������߾�
					Word.Selection.PageSetup.RightMargin = Word.Application.CentimetersToPoints(1.3);  //�����ұ߾�
					Word.Selection.PageSetup.TopMargin = Word.Application.CentimetersToPoints(2);  //�����ұ߾�
					Word.Selection.PageSetup.BottomMargin = Word.Application.CentimetersToPoints(2);  //�����ұ߾�
					Word.Selection.ParagraphFormat.Alignment=1  //���־���
					
					//ѡ��id=title��table
					var range = document.body.createTextRange();
					var reportPage = document.getElementById("reportPage");
					range.moveToElementText(reportPage);  
					range.select();
					document.execCommand('Copy');
					range.moveEnd('character');
					Word.Selection.Paste();  //ճ��Word��
					
					Word.Selection.InsertBreak(7);
					
					var base = document.getElementById("base");
					range.moveToElementText(base);  
					range.select();
					document.execCommand('Copy');
					range.moveEnd('character');
					Word.Selection.Paste();  //ճ��Word��
					
					Word.Selection.InsertBreak(7);
					
					var shoulder = document.getElementById("shoulder");
					range.moveToElementText(shoulder); 
					range.select();
					document.execCommand('Copy');
					range.moveEnd('character');
					Word.Selection.Paste();  //ճ��Word��
					
					Word.Selection.InsertBreak(7);
					
					var safe = document.getElementById("safe");
					range.moveToElementText(safe);  
					range.select();
					document.execCommand('Copy');
					range.moveEnd('character');
					Word.Selection.Paste();  //ճ��Word��
					
					Word.Selection.InsertBreak(7);
					
					var recover = document.getElementById("recover");
					range.moveToElementText(recover);  
					range.select();
					document.execCommand('Copy');
					range.moveEnd('character');
					Word.Selection.Paste();  //ճ��Word��
					
					Word.Selection.InsertBreak(7);
					
					var determine = document.getElementById("determine");
					range.moveToElementText(determine); 
					range.select();
					document.execCommand('Copy');
					range.moveEnd('character');
					Word.Selection.Paste();  //ճ��Word��
					
					Word.ActiveDocument.Tables(1).Rows(1).HeadingFormat = true;
					//Word.ActiveWindow.ActivePane.View.Type = 4;  //��Ԥ����ͼ  
				}
			]]>
		</script>
	</xsl:template>
	<xsl:template match="oilcan-report">
		<html>
			<head>
				<style type="text/css">
					table#one{
						 border-top-width: 1px;
						 border-left-width: 1px;
						 border-top-style: solid;
						 border-left-style: solid;
						 border-top-color: #CCCCCC;
						 border-left-color: #CCCCCC;
						 border-collapse:collapse;
					}
					.tableOne{
						 border-top-width: 2px;
						 border-left-width: 2px;
						 border-top-style: solid;
						 border-left-style: solid;
						 border-top-color: #CCCCCC;
						 border-left-color: #CCCCCC;
						 border-collapse:collapse;
					}
					.tableOne td{
						 border-right-width: 2px;
						 border-bottom-width: 2px;
						 border-right-style: solid;
						 border-bottom-style: solid;
						 border-right-color: #CCCCCC;
						 border-bottom-color: #CCCCCC;
					}
					td#two{
						 border-right-width: 1px;
						 border-bottom-width: 1px;
						 border-right-style: solid;
						 border-bottom-style: solid;
						 border-right-color: #CCCCCC;
						 border-bottom-color: #CCCCCC;
					}
				</style>
			</head>
			<body onload="print();">
				<div id="base" >
					<div style="font-size:25px;font-family:����;font-weight:bold;text-align:center">�� �� �� �� �� �� �� �� �� ��</div>
					<br/>
					<table width="100%" align="center" class="tableOne">
						<tr height="30">
							<td align="center" width="15%">Ʒ���ͺ�</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@brandModel"/></td>
							<td align="center" width="15%" colspan="2">�����պ�</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@carNo"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">���쳧��</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@produce1"/></td>
							<td align="center" width="15%" colspan="2">�����ͺ�</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@carModel"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">��������</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@outDate1"/></td>
							<td align="center" width="15%" colspan="2">���쳧��</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@produce2"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">�׼�����</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@firstCheckDate"/></td>
							<td align="center" width="15%" colspan="2">��������</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@outDate2"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">׼�˽���</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@medium"/></td>
							<td align="center" width="15%" colspan="2">�Ǽ�����</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@regDate"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">�� �� ��<br />�� �� ��</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@lwh"/></td>
							<td align="center" width="15%" colspan="2">�����˶�<br />�� �� ��</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@weightAxis"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">������ע��<br />��(������)</td>
							<td align="center" width="7%" ><xsl:value-of select="base/baseLine/@outCapacity"/></td>
							<td align="center" width="10%">�� �� װ<br />�� �� ��</td>
							<td align="center" width="7%" ><xsl:value-of select="base/baseLine/@allowCapacity"/></td>
							<td align="center" width="14%" colspan="2">�� �� װ<br />�� �� ��</td>
							<td align="center" width="12%"><xsl:value-of select="base/baseLine/@allowWeight"/></td>
							<td align="center" width="10%">��  ��<br />��  ��</td>
							<td align="center" width="7%" ><xsl:value-of select="base/baseLine/@oilcanMaterial"/></td>
							<td align="center" width="11%">����</td>
							<td align="center" width="7%" ><xsl:value-of select="base/baseLine/@warehouseNum"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">�� �� �� ע<br />�� λ �� ��</td>
							<td align="center" width="85%" colspan="10"><xsl:value-of select="base/baseLine/@unitName"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%" rowspan="4">�� �� �� ��<br /><br />�� �� �� ��</td>
							<td align="center" width="17%" colspan="2">�޳��������</td>
							<td align="center" width="21%" colspan="3"><xsl:value-of select="base/baseLine/@outCode"/></td>
							<td align="center" width="22%" colspan="2">�޳��ϸ�֤��</td>
							<td align="center" width="25%" colspan="3"><xsl:value-of select="base/baseLine/@licensedCode"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="17%" colspan="2">����ʶ�����</td>
							<td align="center" width="21%" colspan="3"><xsl:value-of select="base/baseLine/@spotCode"/></td>
							<td align="center" width="22%" colspan="2">�����������֤��</td>
							<td align="center" width="25%" colspan="3"><xsl:value-of select="base/baseLine/@checkCode"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="17%" colspan="2">�ʼ��������</td>
							<td align="center" width="68%" colspan="8"><xsl:value-of select="base/baseLine/@organizationName"/></td>
						</tr>
						<tr height="40">
							<td align="left" colspan="10"><xsl:value-of select="base/baseLine/@convertNote"/></td>
						</tr>
						<tr height="100" valign="top">
							<td align="center" width="15%"><br/>�� ��<br/><br/>�� ¼</td>
							<td align="left" width="85%" colspan="10">
								<xsl:for-each select="checkRecord/checkRecordLine">
									<p><xsl:value-of select="position()"/>.<xsl:value-of select="@description"/></p>
								</xsl:for-each>
							</td>
						</tr>
						<tr height="30">
							<td align="left" colspan="11">������ݣ���GB T18564������ر�׼</td>
						</tr>
						<tr height="100" valign="top">
							<td align="center" width="15%"><br/>��췢�ֵ���<br/><br/>�⼰�������</td>
							<td align="left" width="85%" colspan="10">
								<xsl:for-each select="problem/problemLine">
									<p><xsl:value-of select="position()"/>.<xsl:value-of select="@description"/></p>
								</xsl:for-each>
							</td>
						</tr>
						<tr height="135" align="center">
							<td align="center" width="15%">��<br/><br/><br/>��</td>
							<td align="center" width="38%" colspan="5"><xsl:value-of select="base/baseLine/@conclusion"/></td>
							<td align="left" width="47%" colspan="5"><br/><br/><br/><br/><br/><br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�����λ�����������Ƽ����޹�˾</td>
						</tr>
						<tr height="30" align="center">
							<td align="left" colspan="11">
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							����������<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							���<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;</xsl:text>
							�´β������<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="base/baseLine/@nextCheckDate"/></td>
						</tr>
					</table>
				</div>
				<div id="shoulder">
					<div style="font-size:25px;font-family:����;font-weight:bold;text-align:center">�� �� �� �� ѹ �� �� �� �� ��</div>
					<div style="font-family:����;text-align:right">�� �� �� ��<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@carNo"/></div>
					<table width="100%" align="center" class="tableOne">
						<tr height="50">
							<td align="center" width="10%">�� ��</td>
							<td align="center" width="40%">�� �� �� Ŀ</td>
							<td align="center" width="50%" colspan="2">�� ��</td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">1</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���ڷ�����</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@bulwarkNum"/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@bulwarkState"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">2</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�˿����˿׸Ǹ���������������</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@holeNum"/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@holeState"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">3</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>ע��ڸ������������</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@affluxNum"/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@affluxState"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">4</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>������������ӽ������</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@detroitType"/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@detroitState"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">5</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>������֧�����޷�������</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@hasCrack"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="10%" rowspan="2">6</td>
							<td align="left" width="40%" rowspan="2"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>������ۼ��</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@oilcanShow"/></td>
						</tr>
						<tr height="50">
							<td align="center" width="5%">ȱ<br/>��</td>
							<td align="center" width="45%"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@oilcanDefect"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">7</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>װж��ֱ���͸���</td>
							<td align="center" width="50%" colspan="2" disable-output-escaping="yes"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@diameter"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">8</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�������</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@valveType"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">9</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���Ų���</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@valveMaterial"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">10</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���ż����ӽŵ�Ӧ���������©</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@seepage"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%" rowspan="2">11</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>װж��ܡ����͹ܣ�������ȼ���ױ�Һ��<br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�����Ӧ�е���ͭ˿������ֵ��5����</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@hose"/></td>
						</tr>
						<tr height="30">
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���͹�Ӧ�е����������������</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@refuel"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">12</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>������������װ��</td>
							<td align="center" width="50%" colspan="2">
								<xsl:choose>
									<xsl:when test="oilcanShoulder/oilcanShoulderLine/@recoverSystem='��'">
										<xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@recoverSystem"/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@recoverState"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@recoverSystem"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">13</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���ޱ���װ�ã�Ӧ���������©</td>
							<td align="center" width="50%" colspan="2">
								<xsl:choose>
									<xsl:when test="oilcanShoulder/oilcanShoulderLine/@bengSystem='��'">
										<xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@bengSystem"/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@bengState"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@bengSystem"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">14</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>ж�ϼ���װ��</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@measureSystem"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">15</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�����������п������װ����</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@refitPlace"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">16</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���屣�¼����ڼ��ȹ�</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@oilcanHeat"/></td>
						</tr>
						<tr height="40" style="text-align:center">
							<td align="left" colspan="4"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>����ˣ�<xsl:value-of disable-output-escaping="yes" select="oilcanShoulder/oilcanShoulderLine/@checkPerson"/>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@checkDate"/></td>
						</tr>
					</table>
				</div>
				<div id="safe">
					<div style="font-size:25px;font-family:����;font-weight:bold;text-align:center">�� ȫ �� �� �� �� �� ��</div>
					<div style="font-family:����;text-align:right">�����պ�<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="safeAttachment/safeAttachmentLine/@carNo"/></div>
					<table width="100%" align="center" class="tableOne">
						<tr height="60">
							<td align="center" width="10%">�� ��</td>
							<td align="center" width="30%">�� �� �� Ŀ</td>
							<td align="center" width="30%">�� ��</td>
							<td align="center" width="30%">�� ��</td>
						</tr>
						<tr height="40">
							<td align="center">1</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���������</td>
							<td align="center">������2��</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@fireDevice"/></td>
						</tr>
						<tr height="40">
							<td align="center">2</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>Σ��Ʒ��־��</td>
							<td align="center">1��</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@dangerLamp"/></td>
						</tr>
						<tr height="40">
							<td align="center">3</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>Σ��Ʒ��־��</td>
							<td align="center">1��</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@dangerPlate"/></td>
						</tr>
						<tr height="40">
							<td align="center">4</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�������������Σ�ջ���<br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>��־������</td>
							<td align="center">�������༰�޺�</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@surfaceMark"/></td>
						</tr>
						
						<tr height="40">
							<td align="center">5</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>������������ɫ��</td>
							<td align="center">����Ӧɫ���������ֽ�����<br/>ɫ�����Ӧ��С��150mm</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@paintColor"/></td>
						</tr>
						<tr height="60">
							<td align="center">6</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>������ȼ���ױ�Һ�壬����<br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���������л�Ϩ��������<br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���������ϵͳλ��</td>
							<td align="center">����ǰ����1.5m</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@systemPosition"/></td>
						</tr>
						<tr height="40">
							<td align="center" rowspan="2">7</td>
							<td align="left" rowspan="2"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>����������ǽ��������<br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���壬�е������ʩ</td>
							<td align="center">���������ϵش� ����ֵ��5��</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@rubber"/></td>
						</tr>
						<tr height="40">
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@transmitType"/>����ֵ��5��</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@transmitValue"/></td>
						</tr>
						<tr height="40">
							<td align="center">8</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���廤��</td>
							<td align="center">�����嶥����������2m<br/>ʱ��ƽ̨��ΧӦ��װ����</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@attendance"/></td>
						</tr>
						<tr height="40">
							<td align="center">9</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���¹�����</td>
							<td align="center">Ӧ�����ʵǡ������ι̣���<br/>�Ȳ���350mm���಻��350mm</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@ladder"/></td>
						</tr>
						<tr height="40">
							<td align="center">10</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>������</td>
							<td align="center">�ر����ܣ�����������</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@valveContainer"/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="safeAttachment/safeAttachmentLine/@valveState"/></td>
						</tr>
						<tr height="40">
							<td align="center">11</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>������</td>
							<td align="center">������</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@garnerContainer"/></td>
						</tr>
						<tr height="60">
							<td align="center">12</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>��Դ�ܿ��ؼ������װ��</td>
							<td align="center">��Դ�ܿ���Ӧ����Ϊ���<br/>���أ������������أ���<br/>����װ��Ӧװ�ڼ�ʻ����</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@switchSystem"/></td>
						</tr>
						<tr height="40">
							<td align="center">13</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>����ѹ������ձ�</td>
							<td align="center">������</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@pressure"/></td>
						</tr>
						<tr height="40">
							<td align="center">14</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���������ſշ���������<br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�����</td>
							<td align="center">Ӧȷ���������</td>
							<td align="center">DN<xsl:value-of select="safeAttachment/safeAttachmentLine/@dnLength"/>mm ����<xsl:value-of select="safeAttachment/safeAttachmentLine/@dnNum"/>�� <xsl:value-of select="safeAttachment/safeAttachmentLine/@dnState"/></td>
						</tr>
						<tr height="40">
							<td align="center">15</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�����жϷ�</td>
							<td align="center">Ӧװ���ڹ��ڻ��������ĸ���</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@breakSystem"/></td>
						</tr>
						<tr height="40" style="text-align:center">
							<td align="left" colspan="4"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>����ˣ�<xsl:value-of disable-output-escaping="yes" select="safeAttachment/safeAttachmentLine/@checkPerson"/>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:value-of select="safeAttachment/safeAttachmentLine/@checkDate"/></td>
						</tr>
					</table>
				</div>
				<div id="recover">
					<div style="font-size:18px;font-family:����;font-weight:bold;text-align:center">�� �� �� �� �� �� �� �� �� ��</div>
					<div style="font-family:����;text-align:right">�� �� �� ��<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="recoverDevice/recoverDeviceLine/@carNo"/></div>
					<table width="100%" align="center" class="tableOne">
						<tr height="20">
							<td align="center" width="10%" rowspan="2">����</td>
							<td align="center" width="36%" rowspan="2">�� Ŀ</td>
							<td align="center" width="36%" colspan="4">�� �� �� ��</td>
							<td align="center" width="18%" rowspan="2">�� ע</td>
						</tr>
						<tr height="20">
							<td align="center" width="9%">����</td>
							<td align="center" width="9%">����</td>
							<td align="center" width="9%">����</td>
							<td align="center" width="9%">ȱʧ</td>
						</tr>
						<tr height="20">
							<td align="center" rowspan="8">��<br/><br/>��<br/><br/>��<br/><br/>��</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�ܷ�ʽ���ٽ�ͷ DN 80 mm</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@kissNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@kissState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@kissState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@kissState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@kissNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>ñ��</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@hatNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@hatState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@hatState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@hatState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@hatNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>����������������</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@valveNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@valveState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@valveState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@valveState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@valveNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���ӽ���</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@gluingNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@gluingState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@gluingState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@gluingState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@gluingNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���������·����</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@oilcanPipeNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@oilcanPipeState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@oilcanPipeState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@oilcanPipeState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@oilcanPipeNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>��������β��</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@lineValveNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@lineValveState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@lineValveState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@lineValveState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@lineValveNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�̶�֧��</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@standNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@standState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@standState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@standState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@standNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>ѹ��/��շ�(��������ͨ����)</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@pressureNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@pressureState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@pressureState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@pressureState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@pressureNote"/></td>
						</tr>
						<tr height="20">
							<td align="center" rowspan="6">��<br/><br/>��<br/><br/>װ<br/><br/>��</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>DN100mm�ܷ�ʽ���ٽ�ͷ</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomKissNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomKissState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomKissState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomKissState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomKissNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>ñ��</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomHatNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomHatState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomHatState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomHatState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomHatNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�����׷�</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomValveNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomValveState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomValveState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomValveState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomValveNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�����׷�����ٽ�ͷ֮���м䷧</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@centerValveNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@centerValveState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@centerValveState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@centerValveState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@centerValveNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>������̽��ͷ�Ͳ���</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@outletNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@outletState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@outletState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@outletState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@outletNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>������̽��ͷ��װ�߶�</td>
							<td align="right" colspan="2"><xsl:value-of select="recoverDevice/recoverDeviceLine/@fixHeightNum"/> mm<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text></td>
							<td align="center" colspan="2">������</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@fixHeightState"/></td>
						</tr>
					</table>
					<br/><div style="font-size:18px;font-family:����;font-weight:bold;text-align:center">��������ϵͳ���������չ������������ܱ��Լ�ⱨ��</div><br/>
					<table width="100%" align="center" class="tableOne">
						<tr height="20">
							<td align="center" width="45%" rowspan="2" colspan="2">�Ͳ��ݻ�(m<sup>3</sup>)</td>
							<td align="center" width="11%">1���Ͳ�</td>
							<td align="center" width="11%" colspan="2">2���Ͳ�</td>
							<td align="center" width="11%">3���Ͳ�</td>
							<td align="center" width="11%">4���Ͳ�</td>
							<td align="center" width="11%">5���Ͳ�</td>
						</tr>
						<tr height="20">
							<td align="center" width="11%"><xsl:value-of select="valveHermetic/valveHermeticLine/@firstOilcan1"/></td>
							<td align="center" width="11%" colspan="2"><xsl:value-of select="valveHermetic/valveHermeticLine/@secondOilcan1"/></td>
							<td align="center" width="11%"><xsl:value-of select="valveHermetic/valveHermeticLine/@thirdOilcan1"/></td>
							<td align="center" width="11%"><xsl:value-of select="valveHermetic/valveHermeticLine/@forthOilcan1"/></td>
							<td align="center" width="11%"><xsl:value-of select="valveHermetic/valveHermeticLine/@fifthOilcan1"/></td>
						</tr>
						<tr height="20">
							<td align="left" colspan="8">һ����������ϵͳ�ܱ���</td>
						</tr>
						<tr height="20">
							<td align="center" width="10%">(1)</td>
							<td align="left" width="35%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�ܱ��Լ��ĳ�ʼѹ��(kPa)</td>
							<td align="center">4.5</td>
							<td align="center" colspan="2">4.5</td>
							<td align="center">4.5</td>
							<td align="center">4.5</td>
							<td align="center">4.5</td>
						</tr>
						<tr height="20">
							<td align="center">(2)</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>5min֮���ѹ���䶯��ֵ(kPa)</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>Ӧ��0.25</td>
							<td align="center" colspan="2"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>Ӧ��0.25</td>
							<td align="center"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>Ӧ��0.25</td>
							<td align="center"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>Ӧ��0.25</td>
							<td align="center"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>Ӧ��0.25</td>
						</tr>
						<tr height="20">
							<td align="center">(3)</td>
							<td align="center">�� �� �� ��</td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@firstOilcan2"/></td>
							<td align="center" colspan="2"><xsl:value-of select="valveHermetic/valveHermeticLine/@secondOilcan2"/></td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@thirdOilcan2"/></td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@forthOilcan2"/></td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@fifthOilcan2"/></td>
						</tr>
						<tr height="20">
							<td align="left" colspan="8">�����������չ������������ܱ���</td>
						</tr>
						<tr height="20">
							<td align="center">(1)</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�ܱ��Լ��ĳ�ʼѹ��(kPa)</td>
							<td align="center">0</td>
							<td align="center" colspan="2">0</td>
							<td align="center">0</td>
							<td align="center">0</td>
							<td align="center">0</td>
						</tr>
						<tr height="20">
							<td align="center">(2)</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>5min֮���ѹ���䶯��ֵ(kPa)</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>Ӧ��1.3</td>
							<td align="center" colspan="2"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>Ӧ��1.3</td>
							<td align="center"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>Ӧ��1.3</td>
							<td align="center"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>Ӧ��1.3</td>
							<td align="center"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>Ӧ��1.3</td>
						</tr>
						<tr height="20">
							<td align="center">(3)</td>
							<td align="center">�� �� �� ��</td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@firstOilcan3"/></td>
							<td align="center" colspan="2"><xsl:value-of select="valveHermetic/valveHermeticLine/@secondOilcan3"/></td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@thirdOilcan3"/></td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@forthOilcan3"/></td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@fifthOilcan3"/></td>
						</tr>
						<tr height="20">
							<td align="left" colspan="8"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�� �� �� �� �� �� �� �� ѹ �� �� ��<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="valveHermetic/valveHermeticLine/@pressureStart"/>kPa<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="valveHermetic/valveHermeticLine/@pressureEnd"/>kPa</td>
						</tr>
						<tr height="20">
							<td align="left" colspan="8"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>����������ѹ���Ƿ���ϱ�׼��<xsl:value-of select="valveHermetic/valveHermeticLine/@pressureState"/></td>
						</tr>
						<tr height="40" valign="top">
							<td align="left" colspan="8"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>������أ�<xsl:value-of select="valveHermetic/valveHermeticLine/@question"/></td>
						</tr>
						<tr height="20">
							<td align="left" colspan="8"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>���ۣ�<xsl:value-of select="valveHermetic/valveHermeticLine/@conclusion"/></td>
						</tr>
						<tr height="25" style="text-align:center">
							<td align="left" colspan="8"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>����ˣ�<xsl:value-of disable-output-escaping="yes" select="valveHermetic/valveHermeticLine/@checkPerson"/>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:value-of select="valveHermetic/valveHermeticLine/@checkDate"/></td>
						</tr>
					</table>
				</div>
				<div id="determine">
					<div style="font-size:25px;font-family:����;font-weight:bold;text-align:center">�� �� �� �� �� �� �� �� �� �� �� �� ��</div><br/>
					<div style="font-family:����;text-align:right">�� �� �� ��<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="determineShow/determineShowLine/@carNo"/></div>
					<table width="100%" align="center" class="tableOne">
						<tr height="25">
							<td align="center" colspan="2" width="20%">���������ͺ�</td>
							<td align="center" width="30%"><xsl:value-of select="determineShow/determineShowLine/@deviceModel"/></td>
							<td align="center" width="20%">�� �� �� ��</td>
							<td align="center" width="30%"><xsl:value-of select="determineShow/determineShowLine/@oilcanMaterial"/></td>
						</tr>
						<tr height="25">
							<td align="center" colspan="2" width="20%">������������</td>
							<td align="center" width="30%"><xsl:value-of select="determineShow/determineShowLine/@deviceCrack"/></td>
							<td align="center" width="20%">�� �� �� ��</td>
							<td align="center" width="30%"><xsl:value-of select="determineShow/determineShowLine/@coverHeader"/></td>
						</tr>
						<tr height="25">
							<td align="center" colspan="2" width="20%">�� �� ��</td>
							<td align="center" width="30%"><xsl:value-of select="determineShow/determineShowLine/@coupling"/></td>
							<td align="center" width="20%">�� �� �� ��</td>
							<td align="center" width="30%"><xsl:value-of select="determineShow/determineShowLine/@gaugeNum"/></td>
						</tr>
						<tr height="500" valign="top">
							<td align="center" colspan="5">
								<br/>ʵ������<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
								&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
								&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
								&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
								&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
								&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
								&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
								<table width="80%" align="center" class="tableOne">
									<tr height="20">
										<td align="center" width="20%">������</td>
										<td align="center" width="10%">A1</td>
										<td align="center" width="10%">A2</td>
										<td align="center" width="10%">A3</td>
										<td align="center" width="10%">A4</td>
										<td align="center" width="10%">B1</td>
										<td align="center" width="10%">B2</td>
										<td align="center" width="10%">B3</td>
										<td align="center" width="10%">B4</td>
									</tr>
									<tr height="20">
										<td align="center" width="20%">ʵ����ֵ</td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@a1"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@a2"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@a3"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@a4"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@b1"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@b2"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@b3"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@b4"/></td>
									</tr>
								</table>
								<br />
								<table width="80%" align="center" class="tableOne">
									<tr height="20">
										<td align="center" width="20%">������</td>
										<td align="center" width="10%">C1</td>
										<td align="center" width="10%">C2</td>
										<td align="center" width="10%">C3</td>
										<td align="center" width="10%">C4</td>
										<td align="center" width="10%">D1</td>
										<td align="center" width="10%">D2</td>
										<td align="center" width="10%">D3</td>
										<td align="center" width="10%">D4</td>
									</tr>
									<tr height="20">
										<td align="center" width="20%">ʵ����ֵ</td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@c1"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@c2"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@c3"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@c4"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@d1"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@d2"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@d3"/></td>
										<td align="center" width="10%"><xsl:value-of select="determineShow/determineShowLine/@d4"/></td>
									</tr>
								</table>
								<br/>
								<br/>
										<div><xsl:value-of disable-output-escaping="yes" select="determineShow/determineShowLine/@image"/></div>
										<div><xsl:value-of disable-output-escaping="yes" select="determineShow/determineShowLine/@image1"/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
										&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
										&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
										</xsl:text>
										<xsl:value-of disable-output-escaping="yes" select="determineShow/determineShowLine/@image2"/></div>
								
							</td>
						</tr>
						<tr height="150">
							<td align="center" width="5%">��<br/><br/>��<br/><br/>��<br/><br/>��</td>
							<td align="center" colspan="4"><xsl:value-of select="determineShow/determineShowLine/@showCheck"/></td>
						</tr>
						<tr height="25">
							<td align="left" colspan="5"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�� �� �� �ۣ�<xsl:value-of select="determineShow/determineShowLine/@conclusion"/></td>
						</tr>
						<tr height="40" style="text-align:center">
							<td align="left" colspan="5"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>����ˣ�<xsl:value-of disable-output-escaping="yes" select="determineShow/determineShowLine/@checkPerson"/>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							<xsl:value-of select="determineShow/determineShowLine/@checkDate"/></td>
						</tr>
					</table>
				</div>
				<div id="reportPage">
					<table width="100%" border="0" bordercolor="#000000" align="center" cellpadding="2" cellspacing="0">
						<tr>
							<td width="55%"></td>
							<td width="45%">
								<table border="0" bordercolor="#000000" align="center" cellpadding="2" cellspacing="0">
									<tr>
										<td align="center" width="25%" nowrap="true" style="font-size:16px;font-weight:bold;">
											��<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
											��<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
											��<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
											�ţ�
										</td>
										<td align="center" width="25%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:16px;font-weight:bold;">
											<xsl:value-of select="reportPage/reportPageLine/@code"/>
										</td>
									</tr>
									<tr>
										<td align="center" width="25%" nowrap="true" style="font-size:16px;font-weight:bold;">
											�� �� �� �� �� ��
										</td>
										<td align="center" width="25%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:16px;font-weight:bold;">
											<xsl:value-of select="reportPage/reportPageLine/@materialType"/>
										</td>
									</tr>
									<tr>
										<td align="center" width="25%" nowrap="true" style="font-size:16px;font-weight:bold;">
											׼<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>��<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>��<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>��<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>��<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>��<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>�ţ�
										</td>
										<td align="center" width="25%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:16px;font-weight:bold;">
											<xsl:value-of select="reportPage/reportPageLine/@mediumName"/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
											<xsl:value-of select="reportPage/reportPageLine/@mediumCode"/>
										</td>
									</tr> 
									<tr>
										<td align="center" width="25%" nowrap="true" style="font-size:16px;font-weight:bold;">
											�� �� �� �� �� ��
										</td>
										<td align="center" width="25%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:16px;font-weight:bold;">
											<xsl:value-of select="reportPage/reportPageLine/@mediumType"/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
											<xsl:value-of select="reportPage/reportPageLine/@mediumNote"/>
										</td>
									</tr> 
								</table>
							</td>
						</tr>
					</table>
					<br /><br /><br /><br />
					<div style="font-size:30px;font-family:����;font-weight:bold;text-align:center">�� �� �� ѧ Σ �� Ʒ �� ѹ �� �� �� ��</div>
					<div style="font-size:30px;font-family:����;font-weight:bold;text-align:center">�� �� �� �� �� ��</div>
					<br /><br /><br /><br /><br /><br /><br /><br />
					<div style="text-align:center">
						<table width="60%" border="0" bordercolor="#000000" align="center" cellpadding="2" cellspacing="0">
							<tr>
								<td align="center" width="35%" nowrap="true" style="font-size:18px;font-weight:bold;">
									ʹ�õ�λ���ƣ�
								</td>
								<td align="left" width="65%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:18px;font-weight:bold;">
									<xsl:value-of select="reportPage/reportPageLine/@unitName"/>
								</td>
							</tr>
							<tr>
								<td align="center" width="35%" nowrap="true" style="font-size:18px;font-weight:bold;">
									��<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>��<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>��<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>�ţ�
								</td>
								<td align="left" width="65%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:18px;font-weight:bold;">
									<xsl:value-of select="reportPage/reportPageLine/@carNo"/>
								</td>
							</tr>
							<tr>
								<td align="center" width="35%" nowrap="true" style="font-size:18px;font-weight:bold;">
									�޳��ǼǱ�ţ�
								</td>
								<td align="left" width="65%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:18px;font-weight:bold;">
									<xsl:value-of select="reportPage/reportPageLine/@registerCode"/>
								</td>
							</tr> 
							<tr>
								<td align="center" width="35%" nowrap="true" style="font-size:18px;font-weight:bold;">
									��·����֤�ţ�
								</td>
								<td align="left" width="65%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:18px;font-weight:bold;">
									<xsl:value-of select="reportPage/reportPageLine/@roadCode"/>
								</td>
							</tr> 
							<tr>
								<td align="center" width="35%" nowrap="true" style="font-size:18px;font-weight:bold;">
									�´β�����ڣ�
								</td>
								<td align="left" width="65%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:18px;font-weight:bold;">
									<xsl:value-of select="reportPage/reportPageLine/@nextCheckDate"/>
								</td>
							</tr> 
						</table>
					</div>
					<br /><br /><br /><br /><br /><br /><br /><br /><br />
					<div style="font-size:22px;font-family:����;font-weight:bold;text-align:center">�� �� �� �� · �� �� �� �� �� �� ��</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
