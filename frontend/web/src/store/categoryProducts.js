// import response from '../mocks/products.json';

export const getProductsList = async (categoryId) => {//TODO: fetch from backend by categoryID http://192.168.0.52:80/api/product/products/v1/categoryWeb
	const response = await fetch(`http://192.168.0.52:80/api/product/products/v1/c/${categoryId}?page=1`);

	if (!response.ok) {
			return [];
	}

	return await response.json();
};
