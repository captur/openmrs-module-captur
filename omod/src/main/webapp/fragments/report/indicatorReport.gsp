<%
	ui.decorateWith("kenyaui", "panel", [ heading: definition.name, frameOnly: true ])

	def formatData = { result -> (result != null) ? result : "-" }
%>
<div class="ke-panel-content">
	<% if (definition.description) { %>
	<fieldset>
		<legend>Description</legend>

		${ definition.description }
	</fieldset>
	<% } %>

	<% if (data) { %>
	<fieldset>
		<legend>Parameters</legend>
		<% definition.parameters.each { %>
			${ ui.includeFragment("kenyaui", "widget/dataPoint", [ label: it.label, value: data.context.parameterValues[it.name] ]) }
		<% } %>
	</fieldset>

		<%
		// If report has a single dataset, then it won't be wrapped in a fieldset
		def singleDataset = (data.dataSets.size() == 1)

		data.dataSets.each {
			def ds = it.value
			def dsd = definition.dataSetDefinitions[it.key].parameterizable
		%>

			<% if (!singleDataset) { %><fieldset><legend>${ dsd.description }</legend><% } %>

			<table class="ke-table-vertical">
				<thead>
					<tr>
						<th style="text-align: left">Indicator</th>
						<th style="text-align: left">Description</th>
						<th style="text-align: center">Value</th>
					</tr>
				</thead>
				<tbody>
				<% ds.metaData.columns.each { col -> %>
					<tr>
						<td><strong>${ col.name }</strong></td>
						<td>${ col.label }</td>
						<td style="text-align: center">${ formatData(ds.getData(col)) }</td>
					</tr>
				<% } %>
				</tbody>
			</table>

			<% if (!singleDataset) { %></fieldset><% } %>

		<% } %>
	<% } %>
</div>