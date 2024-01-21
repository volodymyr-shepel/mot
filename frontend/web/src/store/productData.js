export const getProductDataById = async (productId) => {
	const response = await fetch(`http://192.168.0.52:80/api/product/products/v1/p/${productId}`);

	if (!response.ok) {
			throw new Error(`Product with id ${productId} not found`);
	}

	const json = await response.json();
	console.log(json);
	// if (json.length !== 0) { 
	// 	json.sort((a, b) => a["id"] - b["id"]);
	// }
	return json;
};
