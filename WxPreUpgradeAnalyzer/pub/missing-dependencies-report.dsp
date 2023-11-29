<!DOCTYPE html>
<html>
	<head>
		<title>Missing Dependencies Report</title>
		<link rel="stylesheet" type="text/css" href="webMethods.css"/>
	</head>
	<body>
		<form name="testform" method="post" action="/invoke/WxPreUpgradeAnalyzer.report:createUnresolvedReferencesReport" target="body">
			<table width="100%">
				<tbody>
					<tr>
						<td>
							<table class="tableView" cellpadding="2">
								<tbody>
									<tr>
										<td class="heading" colspan="2">Custom Services Using Non-Existent Services or Document Types &nbsp;&nbsp;</td>
									</tr>
									<!-- - - - Inputs Section - - - -->
									<tr>
										<td class="evenrow">
											<i><label for="packageNameFilter">Dependent Package Name Filter (regex) &nbsp;&nbsp;</label></i>
										</td>
										<td class="oddrow-l">
											<input name="packageNameFilter" id="packageNameFilter">
										</td>
									</tr>
									<!--
									<tr>
										<td class="evenrow">
											<label for="ignoreSystemPackages">Ignore System Packages &nbsp;&nbsp;</label>
										</td>
										<td class="evenrow-l">
											<select name="ignoreSystemPackages" id="ignoreSystemPackages" value="true">
												<option value="true">Yes</option>
												<option value="false">No</option>
											</select>
										</td>
									</tr>
									//-->
									<tr>
										<td class="evenrow">
											<i><label for="referencedAssetFilter">Referenced Asset Name Filter (regex) &nbsp;&nbsp;</label></i>
										</td>
										<td class="oddrow-l">
											<input name="referencedAssetFilter" id="referencedAssetFilter">
										</td>
									</tr>
									</tr>
										<td class="action" colspan="2"><input class="button2" type="submit" value="Create Report" onClick="msg.style.display = 'inline';"/></td>
									</tr>
									<tr>
										<td colspan="2" class="message" style="display:none;" id="msg">Creating report. Please wait... <img src="images/loading.gif" style="valign='middle'"/></td>>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</body>
</html>