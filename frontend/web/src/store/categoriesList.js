export const getCategoriesList = async () => {

	const response = await fetch(`http://192.168.0.52/api/product/categories/v1/categoryHierarchy`);
	//categoryWeb/1`);

	if (!response.ok) {
			throw new Error(`Oops, no categories found`);
	}
	const json = await response.json();
	if (json.length !== 0) {
		console.log(json);
		json.sort((a, b) => a["id"] - b["id"]);
	}
	return json;
};
