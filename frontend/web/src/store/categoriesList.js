export const getCategoriesList = async () => {
	const response = await fetch(`http://192.168.0.52/api/product/products/v1/categoryWeb`);

	if (!response.ok) {
			throw new Error(`Oops, no categories found`);
	}

	return await response.json();
};
