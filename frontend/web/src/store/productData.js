import response from './../mocks/response.json';

export const getProductDataById = (productId) => {
  const categories = response.categories;

  for (const category of categories) {
    const products = category.products;

    for (const product of products) {
      if (product.product_id === productId) {
        return product;
      }
    }
  }

  throw new Error(`Product with id ${productId} not found`);
};
