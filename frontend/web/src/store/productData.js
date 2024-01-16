export const getProductDataById = async (productId) => {
	const response = await fetch(`http://192.168.0.52:80/api/product/products/v1/p/${productId}`);

	if (!response.ok) {
			throw new Error(`Product with id ${productId} not found`);
	}

	return await response.json();
};
