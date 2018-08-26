/**
 * Example data provider for the Grid component.
 */
public with sharing class AccountsDemo extends SObjectGridData {

	// ---------------------------------------------
	// ---- CONTROLLING OUR QUERY ------------------
	// ---------------------------------------------

	/*
	 * The name of our database table.
	 */
	private String getObjectName() {
		return 'Account';
	}

	/*
	 * Fields we want from our database table.
	 */
	private Set<String> getSelectFields() {
		return new Set<String>{'Name', 'Type', 'BillingStreet', 'BillingCity', 'BillingState', 'BillingPostalCode', 'BillingCountry', 'Phone', 'AccountNumber', 'Industry', 'AnnualRevenue', 'NumberOfEmployees', 'Description', 'Id', 'LastModifiedDate', 'CreatedDate', 'AccountSource'};
	}

	/*
	 * This method gives us an opportunity to hand build a where clause for an unusual column, for example
	 * if we had a boolean column type we wouldn't want to use the quotes like we have here.
	 */
	private String buildWhereClause(String column, String value) {

		if('<blank>'.equals(value))
			return column + ' = \'\'';

		return column + ' = \'' + String.escapeSingleQuotes(value) + '\'';
	}

	/*
	 * Our default ordering.
	 */
	private String getDefaultOrderByClause() {
		return 'Name ASC';
	}

	// ---------------------------------------------
	// ---- CONTROLLING FRONTEND RECORD SHAPE ------
	// ---------------------------------------------

	/*
	 * This method gives us an opportunity to have different names for fields that we exchange with the frontend
	 * than we do in our database. For our simple example, we will keep the database field names.
	 */
	private String columnNameToDatabaseField(String columnName) {
		return columnName;
	}

	/*
	 * This method gives us an opportunity to modify the structure or field names of the record we actually
	 * send to the frontend. Useful if we want to flatten relationship queries, drop __c, etc. For this simple
	 * demo, we will send the unchanged SObject to the frontend.
	 */
	private Object transform(SObject record) {
		return record;
	}

	// ---------------------------------------------
	// ---- CONTROLLING FILTERING ------------------
	// ---------------------------------------------

	/*
	 * List the column names that we would like to offer filtering on. These names should match the frontend field
	 * names you have chosen, in case you decide to have different names for frontend and database.
	 */
	private List<String> getFilterableColumnNames() {
		return new List<String> {'Type', 'Industry'};
	}

	/*
	 * Utility method to help us build nice looking filter options to show to users.
	 */
	private GridContext.FilterOption getFilterOption(String columnName, String columnValue, String currentSelection, Integer count) {

		if(String.isBlank(columnValue))
			columnValue = '<blank>';

		return new GridContext.FilterOption(
			columnValue,
			columnValue + ' (' + count + ')',
			columnValue.equalsIgnoreCase(currentSelection)
		);
	}
}