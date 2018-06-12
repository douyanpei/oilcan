<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="gb2312"/>
	<xsl:template match="/">
		<xsl:apply-templates />
		<script language="javascript">
			<![CDATA[
				function print() {
					var Word = new ActiveXObject("Word.Application");//
					Word.Application.Visible = true;  //Word通过Application可见
					Word.documents.add();  //新建文档
					Word.Selection.PageSetup.LeftMargin = Word.Application.CentimetersToPoints(1.3);  //重设左边距
					Word.Selection.PageSetup.RightMargin = Word.Application.CentimetersToPoints(1.3);  //重设右边距
					Word.Selection.PageSetup.TopMargin = Word.Application.CentimetersToPoints(2);  //重设右边距
					Word.Selection.PageSetup.BottomMargin = Word.Application.CentimetersToPoints(2);  //重设右边距
					Word.Selection.ParagraphFormat.Alignment=1  //文字居中
					
					//选中id=title的table
					var range = document.body.createTextRange();
					var reportPage = document.getElementById("reportPage");
					range.moveToElementText(reportPage);  
					range.select();
					document.execCommand('Copy');
					range.moveEnd('character');
					Word.Selection.Paste();  //粘到Word中
					
					Word.Selection.InsertBreak(7);
					
					var base = document.getElementById("base");
					range.moveToElementText(base);  
					range.select();
					document.execCommand('Copy');
					range.moveEnd('character');
					Word.Selection.Paste();  //粘到Word中
					
					Word.Selection.InsertBreak(7);
					
					var shoulder = document.getElementById("shoulder");
					range.moveToElementText(shoulder); 
					range.select();
					document.execCommand('Copy');
					range.moveEnd('character');
					Word.Selection.Paste();  //粘到Word中
					
					Word.Selection.InsertBreak(7);
					
					var safe = document.getElementById("safe");
					range.moveToElementText(safe);  
					range.select();
					document.execCommand('Copy');
					range.moveEnd('character');
					Word.Selection.Paste();  //粘到Word中
					
					Word.Selection.InsertBreak(7);
					
					var recover = document.getElementById("recover");
					range.moveToElementText(recover);  
					range.select();
					document.execCommand('Copy');
					range.moveEnd('character');
					Word.Selection.Paste();  //粘到Word中
					
					Word.Selection.InsertBreak(7);
					
					var determine = document.getElementById("determine");
					range.moveToElementText(determine); 
					range.select();
					document.execCommand('Copy');
					range.moveEnd('character');
					Word.Selection.Paste();  //粘到Word中
					
					Word.ActiveDocument.Tables(1).Rows(1).HeadingFormat = true;
					//Word.ActiveWindow.ActivePane.View.Type = 4;  //打开预览视图  
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
					<div style="font-size:25px;font-family:宋体;font-weight:bold;text-align:center">罐 车 基 本 情 况 查 检 报 告</div>
					<br/>
					<table width="100%" align="center" class="tableOne">
						<tr height="30">
							<td align="center" width="15%">品牌型号</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@brandModel"/></td>
							<td align="center" width="15%" colspan="2">车牌照号</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@carNo"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">制造厂名</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@produce1"/></td>
							<td align="center" width="15%" colspan="2">汽车型号</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@carModel"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">出厂日期</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@outDate1"/></td>
							<td align="center" width="15%" colspan="2">制造厂名</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@produce2"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">首检日期</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@firstCheckDate"/></td>
							<td align="center" width="15%" colspan="2">出厂日期</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@outDate2"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">准运介质</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@medium"/></td>
							<td align="center" width="15%" colspan="2">登记日期</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@regDate"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">罐 体 外<br />形 尺 寸</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@lwh"/></td>
							<td align="center" width="15%" colspan="2">汽车核定<br />载 质 量</td>
							<td align="center" width="35%" colspan="4"><xsl:value-of select="base/baseLine/@weightAxis"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">出厂标注容<br />积(立方米)</td>
							<td align="center" width="7%" ><xsl:value-of select="base/baseLine/@outCapacity"/></td>
							<td align="center" width="10%">允 许 装<br />载 容 积</td>
							<td align="center" width="7%" ><xsl:value-of select="base/baseLine/@allowCapacity"/></td>
							<td align="center" width="14%" colspan="2">允 许 装<br />载 质 量</td>
							<td align="center" width="12%"><xsl:value-of select="base/baseLine/@allowWeight"/></td>
							<td align="center" width="10%">罐  体<br />材  质</td>
							<td align="center" width="7%" ><xsl:value-of select="base/baseLine/@oilcanMaterial"/></td>
							<td align="center" width="11%">仓数</td>
							<td align="center" width="7%" ><xsl:value-of select="base/baseLine/@warehouseNum"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%">车 门 标 注<br />单 位 名 称</td>
							<td align="center" width="85%" colspan="10"><xsl:value-of select="base/baseLine/@unitName"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="15%" rowspan="4">资 料 审 查<br /><br />变 更 记 载</td>
							<td align="center" width="17%" colspan="2">罐车出厂编号</td>
							<td align="center" width="21%" colspan="3"><xsl:value-of select="base/baseLine/@outCode"/></td>
							<td align="center" width="22%" colspan="2">罐车合格证号</td>
							<td align="center" width="25%" colspan="3"><xsl:value-of select="base/baseLine/@licensedCode"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="17%" colspan="2">车辆识别代码</td>
							<td align="center" width="21%" colspan="3"><xsl:value-of select="base/baseLine/@spotCode"/></td>
							<td align="center" width="22%" colspan="2">罐体质量监检证号</td>
							<td align="center" width="25%" colspan="3"><xsl:value-of select="base/baseLine/@checkCode"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="17%" colspan="2">质检机构名称</td>
							<td align="center" width="68%" colspan="8"><xsl:value-of select="base/baseLine/@organizationName"/></td>
						</tr>
						<tr height="40">
							<td align="left" colspan="10"><xsl:value-of select="base/baseLine/@convertNote"/></td>
						</tr>
						<tr height="100" valign="top">
							<td align="center" width="15%"><br/>查 检<br/><br/>记 录</td>
							<td align="left" width="85%" colspan="10">
								<xsl:for-each select="checkRecord/checkRecordLine">
									<p><xsl:value-of select="position()"/>.<xsl:value-of select="@description"/></p>
								</xsl:for-each>
							</td>
						</tr>
						<tr height="30">
							<td align="left" colspan="11">查检依据：《GB T18564》及相关标准</td>
						</tr>
						<tr height="100" valign="top">
							<td align="center" width="15%"><br/>查检发现的问<br/><br/>题及处理意见</td>
							<td align="left" width="85%" colspan="10">
								<xsl:for-each select="problem/problemLine">
									<p><xsl:value-of select="position()"/>.<xsl:value-of select="@description"/></p>
								</xsl:for-each>
							</td>
						</tr>
						<tr height="135" align="center">
							<td align="center" width="15%">结<br/><br/><br/>论</td>
							<td align="center" width="38%" colspan="5"><xsl:value-of select="base/baseLine/@conclusion"/></td>
							<td align="left" width="47%" colspan="5"><br/><br/><br/><br/><br/><br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>查件单位：天津市莱亨科技有限公司</td>
						</tr>
						<tr height="30" align="center">
							<td align="left" colspan="11">
							<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							技术负责人<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
							审核<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
							&amp;nbsp;</xsl:text>
							下次查检日期<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="base/baseLine/@nextCheckDate"/></td>
						</tr>
					</table>
				</div>
				<div id="shoulder">
					<div style="font-size:25px;font-family:宋体;font-weight:bold;text-align:center">罐 体 及 承 压 件 查 检 报 告</div>
					<div style="font-family:宋体;text-align:right">车 牌 照 号<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@carNo"/></div>
					<table width="100%" align="center" class="tableOne">
						<tr height="50">
							<td align="center" width="10%">序 号</td>
							<td align="center" width="40%">查 检 项 目</td>
							<td align="center" width="50%" colspan="2">结 果</td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">1</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>罐内防波板</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@bulwarkNum"/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@bulwarkState"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">2</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>人孔与人孔盖个数与紧固严密情况</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@holeNum"/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@holeState"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">3</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>注入口个数及紧固情况</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@affluxNum"/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@affluxState"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">4</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>罐体与底盘连接紧固情况</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@detroitType"/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@detroitState"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">5</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>罐体与支座有无发现裂纹</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@hasCrack"/></td>
						</tr>
						<tr height="30">
							<td align="center" width="10%" rowspan="2">6</td>
							<td align="left" width="40%" rowspan="2"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>罐体外观检查</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@oilcanShow"/></td>
						</tr>
						<tr height="50">
							<td align="center" width="5%">缺<br/>陷</td>
							<td align="center" width="45%"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@oilcanDefect"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">7</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>装卸阀直径和个数</td>
							<td align="center" width="50%" colspan="2" disable-output-escaping="yes"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@diameter"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">8</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>阀门类别</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@valveType"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">9</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>阀门材质</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@valveMaterial"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">10</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>阀门及连接脚垫应完好无外渗漏</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@seepage"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%" rowspan="2">11</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>装卸软管、加油管（输送易燃、易爆液体<br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>的软管应有导电铜丝及电阻值＜5Ω）</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@hose"/></td>
						</tr>
						<tr height="30">
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>加油管应有导静电线且连接完好</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@refuel"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">12</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>有无油气回收装置</td>
							<td align="center" width="50%" colspan="2">
								<xsl:choose>
									<xsl:when test="oilcanShoulder/oilcanShoulderLine/@recoverSystem='有'">
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
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>有无泵送装置，应完好无外渗漏</td>
							<td align="center" width="50%" colspan="2">
								<xsl:choose>
									<xsl:when test="oilcanShoulder/oilcanShoulderLine/@bengSystem='有'">
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
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>卸料计量装置</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@measureSystem"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">15</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>罐体有无自行开孔与改装部件</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@refitPlace"/></td>
						</tr>
						<tr height="40">
							<td align="center" width="10%">16</td>
							<td align="left" width="40%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>罐体保温及罐内加热管</td>
							<td align="center" width="50%" colspan="2"><xsl:value-of select="oilcanShoulder/oilcanShoulderLine/@oilcanHeat"/></td>
						</tr>
						<tr height="40" style="text-align:center">
							<td align="left" colspan="4"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>查检人：<xsl:value-of disable-output-escaping="yes" select="oilcanShoulder/oilcanShoulderLine/@checkPerson"/>
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
					<div style="font-size:25px;font-family:宋体;font-weight:bold;text-align:center">安 全 附 件 查 检 报 告</div>
					<div style="font-family:宋体;text-align:right">车牌照号<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="safeAttachment/safeAttachmentLine/@carNo"/></div>
					<table width="100%" align="center" class="tableOne">
						<tr height="60">
							<td align="center" width="10%">序 号</td>
							<td align="center" width="30%">查 检 项 目</td>
							<td align="center" width="30%">规 定</td>
							<td align="center" width="30%">结 果</td>
						</tr>
						<tr height="40">
							<td align="center">1</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>灭火器数量</td>
							<td align="center">不少于2个</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@fireDevice"/></td>
						</tr>
						<tr height="40">
							<td align="center">2</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>危险品标志灯</td>
							<td align="center">1个</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@dangerLamp"/></td>
						</tr>
						<tr height="40">
							<td align="center">3</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>危险品标志牌</td>
							<td align="center">1个</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@dangerPlate"/></td>
						</tr>
						<tr height="40">
							<td align="center">4</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>罐体表面有运输危险货物<br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>标志及字样</td>
							<td align="center">罐体两侧及罐后</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@surfaceMark"/></td>
						</tr>
						
						<tr height="40">
							<td align="center">5</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>罐体表面油漆和色带</td>
							<td align="center">油漆应色泽鲜明、分界整齐<br/>色带宽度应不小于150mm</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@paintColor"/></td>
						</tr>
						<tr height="60">
							<td align="center">6</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>运输易燃、易爆液体，发动<br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>机排气管有火花熄灭器、距<br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>罐体与泵送系统位置</td>
							<td align="center">车身前方＞1.5m</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@systemPosition"/></td>
						</tr>
						<tr height="40">
							<td align="center" rowspan="2">7</td>
							<td align="left" rowspan="2"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>金属罐体与非金属衬里的<br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>罐体，有导静电措施</td>
							<td align="center">导静电橡胶拖地带 电阻值＜5Ω</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@rubber"/></td>
						</tr>
						<tr height="40">
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@transmitType"/>电阻值＜5Ω</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@transmitValue"/></td>
						</tr>
						<tr height="40">
							<td align="center">8</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>罐体护栏</td>
							<td align="center">当罐体顶部距地面大于2m<br/>时，平台周围应加装护栏</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@attendance"/></td>
						</tr>
						<tr height="40">
							<td align="center">9</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>上下罐梯子</td>
							<td align="center">应便于攀登、连接牢固，宽<br/>度不＜350mm步距不＞350mm</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@ladder"/></td>
						</tr>
						<tr height="40">
							<td align="center">10</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>阀门箱</td>
							<td align="center">关闭严密，箱内无杂物</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@valveContainer"/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="safeAttachment/safeAttachmentLine/@valveState"/></td>
						</tr>
						<tr height="40">
							<td align="center">11</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>蓄电池箱</td>
							<td align="center">封闭完好</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@garnerContainer"/></td>
						</tr>
						<tr height="60">
							<td align="center">12</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>电源总开关及其控制装置</td>
							<td align="center">电源总开关应更换为电磁<br/>开关，尽量靠近蓄电池，其<br/>控制装置应装在驾驶室内</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@switchSystem"/></td>
						</tr>
						<tr height="40">
							<td align="center">13</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>有无压力表、真空表</td>
							<td align="center">外观完好</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@pressure"/></td>
						</tr>
						<tr height="40">
							<td align="center">14</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>呼吸阀、排空阀个数及完<br/><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>好情况</td>
							<td align="center">应确保开启灵活</td>
							<td align="center">DN<xsl:value-of select="safeAttachment/safeAttachmentLine/@dnLength"/>mm 共有<xsl:value-of select="safeAttachment/safeAttachmentLine/@dnNum"/>个 <xsl:value-of select="safeAttachment/safeAttachmentLine/@dnState"/></td>
						</tr>
						<tr height="40">
							<td align="center">15</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>紧急切断阀</td>
							<td align="center">应装置在罐内或紧靠罐体的根部</td>
							<td align="center"><xsl:value-of select="safeAttachment/safeAttachmentLine/@breakSystem"/></td>
						</tr>
						<tr height="40" style="text-align:center">
							<td align="left" colspan="4"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>查检人：<xsl:value-of disable-output-escaping="yes" select="safeAttachment/safeAttachmentLine/@checkPerson"/>
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
					<div style="font-size:18px;font-family:宋体;font-weight:bold;text-align:center">油 气 回 收 设 备 检 查 报 告</div>
					<div style="font-family:宋体;text-align:right">车 牌 照 号<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="recoverDevice/recoverDeviceLine/@carNo"/></div>
					<table width="100%" align="center" class="tableOne">
						<tr height="20">
							<td align="center" width="10%" rowspan="2">分类</td>
							<td align="center" width="36%" rowspan="2">项 目</td>
							<td align="center" width="36%" colspan="4">查 检 结 果</td>
							<td align="center" width="18%" rowspan="2">备 注</td>
						</tr>
						<tr height="20">
							<td align="center" width="9%">数量</td>
							<td align="center" width="9%">良好</td>
							<td align="center" width="9%">破损</td>
							<td align="center" width="9%">缺失</td>
						</tr>
						<tr height="20">
							<td align="center" rowspan="8">油<br/><br/>气<br/><br/>回<br/><br/>收</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>密封式快速接头 DN 80 mm</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@kissNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@kissState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@kissState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@kissState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@kissNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>帽盖</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@hatNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@hatState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@hatState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@hatState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@hatNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>油气管线气动阀门</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@valveNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@valveState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@valveState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@valveState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@valveNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>连接胶管</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@gluingNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@gluingState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@gluingState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@gluingState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@gluingNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>多仓油气管路并联</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@oilcanPipeNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@oilcanPipeState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@oilcanPipeState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@oilcanPipeState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@oilcanPipeNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>油气管线尾阀</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@lineValveNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@lineValveState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@lineValveState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@lineValveState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@lineValveNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>固定支架</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@standNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@standState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@standState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@standState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@standNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>压力/真空阀(呼吸阀、通气阀)</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@pressureNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@pressureState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@pressureState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@pressureState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@pressureNote"/></td>
						</tr>
						<tr height="20">
							<td align="center" rowspan="6">底<br/><br/>部<br/><br/>装<br/><br/>油</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>DN100mm密封式快速接头</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomKissNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomKissState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomKissState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomKissState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomKissNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>帽盖</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomHatNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomHatState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomHatState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomHatState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomHatNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>气动底阀</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomValveNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomValveState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomValveState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomValveState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@bottomValveNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>气动底阀与快速接头之间中间阀</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@centerValveNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@centerValveState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@centerValveState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@centerValveState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@centerValveNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>防溢流探测头和插座</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@outletNum"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@outletState1"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@outletState2"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@outletState3"/></td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@outletNote"/></td>
						</tr>
						<tr height="20">
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>防溢流探测头安装高度</td>
							<td align="right" colspan="2"><xsl:value-of select="recoverDevice/recoverDeviceLine/@fixHeightNum"/> mm<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text></td>
							<td align="center" colspan="2">灵敏度</td>
							<td align="center"><xsl:value-of select="recoverDevice/recoverDeviceLine/@fixHeightState"/></td>
						</tr>
					</table>
					<br/><div style="font-size:18px;font-family:宋体;font-weight:bold;text-align:center">油气回收系统和油气回收管线气动阀门密闭性检测报告</div><br/>
					<table width="100%" align="center" class="tableOne">
						<tr height="20">
							<td align="center" width="45%" rowspan="2" colspan="2">油仓容积(m<sup>3</sup>)</td>
							<td align="center" width="11%">1号油仓</td>
							<td align="center" width="11%" colspan="2">2号油仓</td>
							<td align="center" width="11%">3号油仓</td>
							<td align="center" width="11%">4号油仓</td>
							<td align="center" width="11%">5号油仓</td>
						</tr>
						<tr height="20">
							<td align="center" width="11%"><xsl:value-of select="valveHermetic/valveHermeticLine/@firstOilcan1"/></td>
							<td align="center" width="11%" colspan="2"><xsl:value-of select="valveHermetic/valveHermeticLine/@secondOilcan1"/></td>
							<td align="center" width="11%"><xsl:value-of select="valveHermetic/valveHermeticLine/@thirdOilcan1"/></td>
							<td align="center" width="11%"><xsl:value-of select="valveHermetic/valveHermeticLine/@forthOilcan1"/></td>
							<td align="center" width="11%"><xsl:value-of select="valveHermetic/valveHermeticLine/@fifthOilcan1"/></td>
						</tr>
						<tr height="20">
							<td align="left" colspan="8">一、油气回收系统密闭性</td>
						</tr>
						<tr height="20">
							<td align="center" width="10%">(1)</td>
							<td align="left" width="35%"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>密闭性检测的初始压力(kPa)</td>
							<td align="center">4.5</td>
							<td align="center" colspan="2">4.5</td>
							<td align="center">4.5</td>
							<td align="center">4.5</td>
							<td align="center">4.5</td>
						</tr>
						<tr height="20">
							<td align="center">(2)</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>5min之后的压力变动限值(kPa)</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>应≤0.25</td>
							<td align="center" colspan="2"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>应≤0.25</td>
							<td align="center"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>应≤0.25</td>
							<td align="center"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>应≤0.25</td>
							<td align="center"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>应≤0.25</td>
						</tr>
						<tr height="20">
							<td align="center">(3)</td>
							<td align="center">检 测 结 果</td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@firstOilcan2"/></td>
							<td align="center" colspan="2"><xsl:value-of select="valveHermetic/valveHermeticLine/@secondOilcan2"/></td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@thirdOilcan2"/></td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@forthOilcan2"/></td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@fifthOilcan2"/></td>
						</tr>
						<tr height="20">
							<td align="left" colspan="8">二、油气回收管线气动阀门密闭性</td>
						</tr>
						<tr height="20">
							<td align="center">(1)</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>密闭性检测的初始压力(kPa)</td>
							<td align="center">0</td>
							<td align="center" colspan="2">0</td>
							<td align="center">0</td>
							<td align="center">0</td>
							<td align="center">0</td>
						</tr>
						<tr height="20">
							<td align="center">(2)</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>5min之后的压力变动限值(kPa)</td>
							<td align="left"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>应≤1.3</td>
							<td align="center" colspan="2"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>应≤1.3</td>
							<td align="center"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>应≤1.3</td>
							<td align="center"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>应≤1.3</td>
							<td align="center"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>应≤1.3</td>
						</tr>
						<tr height="20">
							<td align="center">(3)</td>
							<td align="center">检 测 结 果</td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@firstOilcan3"/></td>
							<td align="center" colspan="2"><xsl:value-of select="valveHermetic/valveHermeticLine/@secondOilcan3"/></td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@thirdOilcan3"/></td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@forthOilcan3"/></td>
							<td align="center"><xsl:value-of select="valveHermetic/valveHermeticLine/@fifthOilcan3"/></td>
						</tr>
						<tr height="20">
							<td align="left" colspan="8"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>呼 吸 阀 开 启 及 吸 入 压 力 检 测<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="valveHermetic/valveHermeticLine/@pressureStart"/>kPa<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="valveHermetic/valveHermeticLine/@pressureEnd"/>kPa</td>
						</tr>
						<tr height="20">
							<td align="left" colspan="8"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>呼吸阀开启压力是否符合标准：<xsl:value-of select="valveHermetic/valveHermeticLine/@pressureState"/></td>
						</tr>
						<tr height="40" valign="top">
							<td align="left" colspan="8"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>问题记载：<xsl:value-of select="valveHermetic/valveHermeticLine/@question"/></td>
						</tr>
						<tr height="20">
							<td align="left" colspan="8"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>结论：<xsl:value-of select="valveHermetic/valveHermeticLine/@conclusion"/></td>
						</tr>
						<tr height="25" style="text-align:center">
							<td align="left" colspan="8"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>检测人：<xsl:value-of disable-output-escaping="yes" select="valveHermetic/valveHermeticLine/@checkPerson"/>
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
					<div style="font-size:25px;font-family:宋体;font-weight:bold;text-align:center">罐 体 壁 厚 测 定 与 外 观 检 查 报 告</div><br/>
					<div style="font-family:宋体;text-align:right">车 牌 照 号<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text><xsl:value-of select="determineShow/determineShowLine/@carNo"/></div>
					<table width="100%" align="center" class="tableOne">
						<tr height="25">
							<td align="center" colspan="2" width="20%">测量仪器型号</td>
							<td align="center" width="30%"><xsl:value-of select="determineShow/determineShowLine/@deviceModel"/></td>
							<td align="center" width="20%">罐 体 材 质</td>
							<td align="center" width="30%"><xsl:value-of select="determineShow/determineShowLine/@oilcanMaterial"/></td>
						</tr>
						<tr height="25">
							<td align="center" colspan="2" width="20%">测量仪器精度</td>
							<td align="center" width="30%"><xsl:value-of select="determineShow/determineShowLine/@deviceCrack"/></td>
							<td align="center" width="20%">公 称 厚 度</td>
							<td align="center" width="30%"><xsl:value-of select="determineShow/determineShowLine/@coverHeader"/></td>
						</tr>
						<tr height="25">
							<td align="center" colspan="2" width="20%">耦 合 剂</td>
							<td align="center" width="30%"><xsl:value-of select="determineShow/determineShowLine/@coupling"/></td>
							<td align="center" width="20%">测 量 点 数</td>
							<td align="center" width="30%"><xsl:value-of select="determineShow/determineShowLine/@gaugeNum"/></td>
						</tr>
						<tr height="500" valign="top">
							<td align="center" colspan="5">
								<br/>实测结果：<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
								&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
								&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
								&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
								&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
								&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
								&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
								<table width="80%" align="center" class="tableOne">
									<tr height="20">
										<td align="center" width="20%">测厚点编号</td>
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
										<td align="center" width="20%">实测厚度值</td>
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
										<td align="center" width="20%">测厚点编号</td>
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
										<td align="center" width="20%">实测厚度值</td>
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
							<td align="center" width="5%">外<br/><br/>观<br/><br/>检<br/><br/>查</td>
							<td align="center" colspan="4"><xsl:value-of select="determineShow/determineShowLine/@showCheck"/></td>
						</tr>
						<tr height="25">
							<td align="left" colspan="5"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>检 测 结 论：<xsl:value-of select="determineShow/determineShowLine/@conclusion"/></td>
						</tr>
						<tr height="40" style="text-align:center">
							<td align="left" colspan="5"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>检测人：<xsl:value-of disable-output-escaping="yes" select="determineShow/determineShowLine/@checkPerson"/>
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
											报<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
											告<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
											编<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
											号：
										</td>
										<td align="center" width="25%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:16px;font-weight:bold;">
											<xsl:value-of select="reportPage/reportPageLine/@code"/>
										</td>
									</tr>
									<tr>
										<td align="center" width="25%" nowrap="true" style="font-size:16px;font-weight:bold;">
											罐 体 材 质 类 别：
										</td>
										<td align="center" width="25%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:16px;font-weight:bold;">
											<xsl:value-of select="reportPage/reportPageLine/@materialType"/>
										</td>
									</tr>
									<tr>
										<td align="center" width="25%" nowrap="true" style="font-size:16px;font-weight:bold;">
											准<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>运<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>介<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>质<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>及<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>编<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>号：
										</td>
										<td align="center" width="25%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:16px;font-weight:bold;">
											<xsl:value-of select="reportPage/reportPageLine/@mediumName"/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
											<xsl:value-of select="reportPage/reportPageLine/@mediumCode"/>
										</td>
									</tr> 
									<tr>
										<td align="center" width="25%" nowrap="true" style="font-size:16px;font-weight:bold;">
											介 质 归 属 类 别：
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
					<div style="font-size:30px;font-family:宋体;font-weight:bold;text-align:center">在 用 化 学 危 险 品 常 压 汽 车 罐 车</div>
					<div style="font-size:30px;font-family:宋体;font-weight:bold;text-align:center">年 度 查 检 报 告</div>
					<br /><br /><br /><br /><br /><br /><br /><br />
					<div style="text-align:center">
						<table width="60%" border="0" bordercolor="#000000" align="center" cellpadding="2" cellspacing="0">
							<tr>
								<td align="center" width="35%" nowrap="true" style="font-size:18px;font-weight:bold;">
									使用单位名称：
								</td>
								<td align="left" width="65%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:18px;font-weight:bold;">
									<xsl:value-of select="reportPage/reportPageLine/@unitName"/>
								</td>
							</tr>
							<tr>
								<td align="center" width="35%" nowrap="true" style="font-size:18px;font-weight:bold;">
									车<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>牌<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>照<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>号：
								</td>
								<td align="left" width="65%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:18px;font-weight:bold;">
									<xsl:value-of select="reportPage/reportPageLine/@carNo"/>
								</td>
							</tr>
							<tr>
								<td align="center" width="35%" nowrap="true" style="font-size:18px;font-weight:bold;">
									罐车登记编号：
								</td>
								<td align="left" width="65%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:18px;font-weight:bold;">
									<xsl:value-of select="reportPage/reportPageLine/@registerCode"/>
								</td>
							</tr> 
							<tr>
								<td align="center" width="35%" nowrap="true" style="font-size:18px;font-weight:bold;">
									道路运输证号：
								</td>
								<td align="left" width="65%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:18px;font-weight:bold;">
									<xsl:value-of select="reportPage/reportPageLine/@roadCode"/>
								</td>
							</tr> 
							<tr>
								<td align="center" width="35%" nowrap="true" style="font-size:18px;font-weight:bold;">
									下次查检日期：
								</td>
								<td align="left" width="65%" nowrap="true" style="border-bottom-style:solid;border-bottom-width:thin;font-size:18px;font-weight:bold;">
									<xsl:value-of select="reportPage/reportPageLine/@nextCheckDate"/>
								</td>
							</tr> 
						</table>
					</div>
					<br /><br /><br /><br /><br /><br /><br /><br /><br />
					<div style="font-size:22px;font-family:宋体;font-weight:bold;text-align:center">天 津 市 道 路 运 输 管 理 处 监 制</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
