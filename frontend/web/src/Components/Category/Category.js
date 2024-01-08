import React, { useState, useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';
import { List, ListItem } from '@mui/material';
import Grid from '@mui/material/Grid';
import Card from '@mui/material/Card';
import Breadcrumbs from '@mui/material/Breadcrumbs';
import FormControl from '@mui/material/FormControl';
import InputLabel from '@mui/material/InputLabel';
import Input from '@mui/material/Input';
import Select from '@mui/material/Select';
import TextField from '@mui/material/TextField';
import Pagination from '@mui/material/Pagination';
import MenuItem from '@mui/material/MenuItem';
import { setSelectedCategory, setCategories } from './../../store/categorySlice';
import { getCategoryData } from './../../store/categoryData';
import { Link, useParams, useNavigate } from 'react-router-dom';
import ShoppingCartIcon from '@mui/icons-material/ShoppingCart';
import { addToCart } from './../../store/cartSlice';

function Category() {
	const dispatch = useDispatch();
	const navigate = useNavigate();
	const { id } = useParams();
	const selectedCategory = useSelector((state) => state.category.selectedCategory);
	const categories = useSelector((state) => state.category.categories);
	const [productsPerPage, setProductsPerPage] = useState(3); // products quantity on a page
	const [currentPage, setCurrentPage] = useState(1); // current page
	const [sortMethod, setSortMethod] = useState('price-asc'); // sorting method
	const [priceFilter, setPriceFilter] = useState({ from: '', to: '' });
	const [filterFrom, setFilterFrom] = useState('');
	const [filterTo, setFilterTo] = useState('');
	let filteredProducts = [];
	const productsPerPageOptions = [3, 6, 9];
	const handleResetFilter = () => {
		setFilterFrom('');
		setFilterTo('');
		setPriceFilter({ from: '', to: '' });
	};
	const resetAllFilters = () => {
		handleResetFilter();
		setCurrentPage(1);
		setProductsPerPage(3);
		setSortMethod('price-asc');
	}
	const handleProductClick = (productId) => {
		navigate(`/product/${productId}`);
	};

	const handleAddToCart = (product) => {
		const cartItem = {
			id: product.product_id,
			name: product.name,
			price: product.price,
			available: product.quantity,
			imageUrl: product.image_url,
			quantityToOrder: 1, // Set quantity to 1
		};
		dispatch(addToCart(cartItem));
	};

	useEffect(() => {
		const fetchData = () => {
			try {
				const data = getCategoryData();
				dispatch(setCategories(data.categories));
				const categoryId = parseInt(id, 10);
				if (
					!/^\d+$/.test(id) //check if id doesn't contain digits only
					|| !data.categories.some((category) => category.id === categoryId) //check if id don't match any existing id
					) {
					navigate('/'); // Redirect to home page 
					//TODO: add redirect to page 404
					return;
				}
				const foundCategory = data.categories.find((category) => category.id === categoryId);
				if (foundCategory) {
					dispatch(setSelectedCategory(foundCategory));
				} else {
					navigate('/'); // Redirect to home page
				}
			} catch (error) {
				console.error('Error fetching data:', error);
			}
		};
		fetchData();
	}, [dispatch, id, navigate, productsPerPage, currentPage, sortMethod, priceFilter]);

	const handleCategoryClick = (category) => {
		dispatch(setSelectedCategory(category));
		resetAllFilters();
	};

	const products = selectedCategory?.products || []; //'|| []' is needed for page refresh or opening a page by direct link 

	const handleSortMethodChange = (event) => {
		setSortMethod(event.target.value);
	};

	// Function to sort products
	const sortProducts = (a, b) => {
		switch (sortMethod) {
		case 'price-asc':
			return a.price - b.price;
		case 'price-desc':
			return b.price - a.price;
		case 'name-asc':
			return a.name.localeCompare(b.name);
		case 'name-desc':
			return b.name.localeCompare(a.name);
		default:
			return 0;
		}
	};

	const sortedProducts = [...products].sort(sortProducts);

	// Function to get filtered and sorted products on the current page
	const getDisplayedProducts = () => {
		filteredProducts = sortedProducts.filter((product) => {
			const productPrice = Number(product.price);
			const from = priceFilter.from !== '' ? Number(priceFilter.from) : 0;
			const to = priceFilter.to !== '' ? Number(priceFilter.to) : Infinity;
			return productPrice >= from && productPrice <= to;
		});

		const startIndex = (currentPage - 1) * productsPerPage;
		const endIndex = startIndex + productsPerPage;

		return filteredProducts.slice(startIndex, endIndex);
	};

	const displayedProducts = getDisplayedProducts();

	const handleProductsPerPageChange = (event) => {
		setProductsPerPage(event.target.value);
		setCurrentPage(1); // Reset current page on change products quantity on a page
	};

	const handlePageChange = (event, value) => {
		setCurrentPage(value);
	};

	const handleApplyFilter = () => {
		// use filterFrom and filterTo to update priceFilter
		setPriceFilter({
			from: filterFrom,
			to: filterTo,
		});
	};

	const formatPrice = (price) => {
		return price.toFixed(2);
	};

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
				<Breadcrumbs sx={{mb: 1}} separator="›" aria-label="breadcrumb">
					<Link underline="hover" color="inherit" to="/">
						Home
					</Link>
					<Typography color="text.primary">{selectedCategory?.categoryName}</Typography>
				</Breadcrumbs>
				<Typography variant='h4' component="h1">
					{selectedCategory?.categoryName}
				</Typography>
				<Box mt={2} display="flex" flexWrap="wrap" justifyContent="space-between" gap={2} alignItems="center">
					<FormControl sx={{minWidth: 150,}}>
						<TextField
							select
							label="Products per page"
							value={productsPerPage}
							onChange={handleProductsPerPageChange}
							variant="standard"
							SelectProps={{
								native: true,
							}}
						>
							{productsPerPageOptions.map((option) => (
								<option key={option} value={option}>{option}</option>
							))}
						</TextField>
					</FormControl>
					<FormControl sx={{minWidth: 150,}}>
						<TextField
							select
							label="Sort by"
							value={sortMethod}
							onChange={handleSortMethodChange}
							variant="standard"
							SelectProps={{
								native: true,
							}}
						>
							<option value="price-asc">Price Asc</option>
							<option value="price-desc">Price Desc</option>
							<option value="name-asc">Product Name Asc</option>
							<option value="name-desc">Product Name Desc</option>
						</TextField>
					</FormControl>
					<Box display="flex" flexWrap="wrap" justifyContent="space-between" alignItems="center" gap={2}>
						<FormControl sx={{ minWidth: 150,}}>
							<TextField
								type="number"
								label="Price from $"
								id="price-filter-from"
								variant="standard"
								value={filterFrom}
								onChange={(e) => setFilterFrom(e.target.value)}
							/>
						</FormControl>
						<FormControl sx={{ minWidth: 150,}}>
							<TextField
								type="number"
								label="Price to $"
								id="price-filter-frtoom"
								variant="standard"
								value={filterTo}
								onChange={(e) => setFilterTo(e.target.value)}
							/>
						</FormControl>
						<Button
							size="large"
							variant="contained"
							color="primary"
							onClick={handleApplyFilter}
						>
							Apply
						</Button>
						<Button
							size="large"
							variant="outlined"
							color="primary"
							onClick={handleResetFilter}
						>
							Reset
						</Button>
					</Box>
				</Box>
				<Grid container spacing={4} mt={0}>
					{displayedProducts.map((product) =>(
					<Grid item xs={12} sm={6} md={4} key={product.product_id}>
						<Card variant="outlined" sx={{p: 2}}>
							<Box
								component="img"
								sx={{
									width: '100%',
								}}
								alt={product.name}
								src={product.image_url}
							/>
							<Typography variant='h6' component="h2" ml={-1}>
								<Button component={Link} onClick={() => handleProductClick(product.product_id)} to={`/product/${product.product_id}`}>{product.name}</Button>
							</Typography>
							<Typography variant='p' component="p" mb={1}>${formatPrice(product.price)}</Typography>
							<Button
								size="large"
								edge="start"
								variant="outlined"
								color="primary"
								aria-label="Add to Cart"
								onClick={() => handleAddToCart(product)}
							>
								<ShoppingCartIcon sx={{ mr: 1 }} />Add to Cart
							</Button>
						</Card>
					</Grid>
					))}
				</Grid>
				<Pagination
					sx={{
						mt: 2,
						display: "flex",
						justifyContent: "flex-end"
					}}
					count={Math.ceil(filteredProducts.length / productsPerPage)}
					page={currentPage}
					onChange={handlePageChange}
				/>
			</Box>
		</Box>
	);
}

export default Category;

