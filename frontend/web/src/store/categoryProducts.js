// import response from '../mocks/products.json';

export const getProductsList = async (categoryId) => {//TODO: fetch from backend by categoryID http://192.168.0.52:80/api/product/products/v1/categoryWeb
	const response = await fetch(`http://192.168.137.1:80/api/product/products/v1/pc/${categoryId}?page=1`);

	if (!response.ok) {
			return [];
	}
	const json = await response.json();
	if (json.length !== 0) {
		console.log(json);

		json.sort((a, b) => a["id"] - b["id"]);
	}
	return json;
};
