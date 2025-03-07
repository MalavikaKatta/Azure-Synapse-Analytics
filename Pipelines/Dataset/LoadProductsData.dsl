source(output(
		ProductID as string,
		ProductName as string,
		Color as string,
		Size as string,
		ListPrice as decimal(10,0),
		Discontinued as boolean
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> ProductsText
source(output(
		ProductKey as integer,
		ProductAltKey as string,
		ProductName as string,
		Color as string,
		Size as string,
		ListPrice as decimal(19,4),
		Discontinued as boolean
	),
	allowSchemaDrift: true,
	validateSchema: false,
	isolationLevel: 'READ_UNCOMMITTED',
	format: 'table',
	staged: true) ~> ProductTable
ProductsText, ProductTable lookup(ProductID == ProductAltKey,
	multiple: false,
	pickup: 'last',
	asc(ProductKey, true),
	broadcast: 'auto')~> MatchedProducts
MatchedProducts alterRow(insertIf(isNull(ProductKey)),
	upsertIf(not(isNull(ProductKey)))) ~> SetLoadAction
SetLoadAction sink(allowSchemaDrift: true,
	validateSchema: false,
	input(
		ProductKey as integer,
		ProductAltKey as string,
		ProductName as string,
		Color as string,
		Size as string,
		ListPrice as decimal(19,4),
		Discontinued as boolean
	),
	deletable:false,
	insertable:true,
	updateable:false,
	upsertable:true,
	keys:['ProductAltKey'],
	format: 'table',
	staged: true,
	allowCopyCommand: true,
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	errorHandlingOption: 'stopOnFirstError',
	mapColumn(
		ProductAltKey = ProductID,
		ProductName = ProductsText@ProductName,
		Color = ProductsText@Color,
		Size = ProductsText@Size,
		ListPrice = ProductsText@ListPrice,
		Discontinued = ProductTable@Discontinued
	)) ~> DimProductTable