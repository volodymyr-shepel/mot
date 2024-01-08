import React, { useState, useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Box, Breadcrumbs, Button, Grid, FormControl, List, ListItem, Table, TableBody, TableRow, TableCell, TextField, Typography } from '@mui/material';
import { Link, useParams } from 'react-router-dom';
import { setSelectedCategory, setCategories } from './../../store/categorySlice';
import { getProductDataById } from './../../store/productData';
import { getCategoryData } from './../../store/categoryData';
import { addToCart } from './../../store/cartSlice';

function Product() {
	const dispatch = useDispatch();
	const { id } = useParams();
	const [productData, setProductData] = useState(null);
	const [error, setError] = useState(null);
	const selectedCategory = useSelector((state) => state.category.selectedCategory);
	const categories = useSelector((state) => state.category.categories);
	const [quantityToAdd, setQuantityToAdd] = useState(1);
	const formatPrice = (price) => {
		return price.toFixed(2);
	};

	const handleCategoryClick = (category) => {
		dispatch(setSelectedCategory(category));
	};

	const handleAddToCart = () => {
		// Create an object with product info
		const cartItem = {
			id: productData.product_id,
			name: productData.name,
			price: productData.price,
			available: productData.quantity,
			imageUrl: productData.image_url,
			quantityToOrder: parseInt(quantityToAdd, 10),
		};
		console.log(cartItem);
		dispatch(addToCart(cartItem));
	};

	useEffect(() => {
		const fetchData = async () => {
			try {
				const data = getProductDataById(id);
				setProductData(data);

				// Begin: get categories list and selected category for case of page refresh or open direct link to product
				const dataCategories = getCategoryData();
				dispatch(setCategories(dataCategories.categories));

				const parentCategoryId = data.categoryId;

				const restoredSelectedCategory = dataCategories.categories.find(category => category.id === parentCategoryId);
		        dispatch(setSelectedCategory(restoredSelectedCategory));
				// End: get categories list and selected category for case pf page refresh or open direct link to product
			} catch (error) {
				console.error('Error fetching product data:', error);
				setError(error.message);
			}
		};

		fetchData();
	}, [dispatch, id]);

	return (
		<Box
			sx={{
				display: 'flex',
				flexGrow: 1,
				flexShrink: 1,
				flexBasis: '100%'
			}}
		>
			<List 
				sx={{
					flexGrow: 0,
					flexShrink: 0,
					flexBasis: '200px'
				}}
			>
				{categories.map((category) => (
				(category.products) &&
					<ListItem key={category.id}>
						<Button component={Link} to={`/category/${category.id}`} onClick={() => handleCategoryClick(category)} style={{fontWeight: category.id === selectedCategory?.id ? 'bold' : 'normal',
				}}>
							{category.categoryName}
						</Button>
					</ListItem>
				))}
			</List>
			<Box sx={{ px: 3, py: 3, flexBasis: '100%' }}>
				{error && <p>Error: {error}</p>}
				{productData && (
					<>
						<Breadcrumbs sx={{mb: 1}} separator="›" aria-label="breadcrumb">
							<Link underline="hover" color="inherit" to="/">
								Home
							</Link>
							<Link underline="hover" color="inherit" to={`/category/${selectedCategory.id}`}>
								{selectedCategory?.categoryName}
							</Link>
							<Typography color="text.primary">{productData.name}</Typography>
						</Breadcrumbs>
						<Typography variant='h4' component="h1">
							{productData.name}
						</Typography>
						<Grid container spacing={4} mt={-2}>
							<Grid item xs={12} sm={12} md={4}>
								<Box
										component="img"
										sx={{
											width: '100%',
											marginTop: 1,
											border: '1px solid rgba(0, 0, 0, 0.12)',
										}}
										alt={productData.name}
										src={productData.image_url}
									/>
							</Grid>
							<Grid item xs={12} sm={12} md={8}>
								<Typography variant='h5' component="p" mb={1}>Price: ${formatPrice(productData.price)}</Typography>
								<Typography variant='p' component="p" mb={1}>SKU: {productData.sku}</Typography>
								<Typography variant='h5' component="h6">Description</Typography>
								<Typography variant='p' component="p" mb={1}>{productData.description}</Typography>
								<Typography variant="h5" component="h6">Specification</Typography>
								{productData.specification.map((spec, index) => (
									<Table key={index} sx={{mb: 4}}>
										<TableBody>
										{Object.entries(spec).map(([key, value]) => (
											<TableRow key={key}>
												<TableCell variant="th" component="th">{key}</TableCell>
												<TableCell>{value}</TableCell>
											</TableRow>
										))}
										</TableBody>
									</Table>
								))}
								<Box display="flex" justifyContent="flex-end">
									<Box display="flex" flexWrap="wrap" justifyContent="flex-start" alignItems="center" gap={2}>
										<FormControl sx={{ width: 100,}}>
											<TextField
												type="number"
												label="Add to cart"
												id="add-to-cart"
												variant="standard"
												value={quantityToAdd}
												onChange={(e) => setQuantityToAdd(Math.max(1, Math.min(productData.quantity, e.target.value)))}
											/>
										</FormControl>
										<Typography variant="p" component="div" alignSelf="center">
											from {productData.quantity} available
										</Typography>
										<Button
											size="large"
											variant="contained"
											color="primary"
											onClick={handleAddToCart}
										>
											Add to cart
										</Button>
									</Box>
								</Box>
							</Grid>
						</Grid>
					</>
				)}
			</Box>
		</Box>
	);
}

export default Product;

