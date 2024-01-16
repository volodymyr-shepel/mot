import React, { useState, useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Box, Breadcrumbs, Button, Grid, FormControl, TextField, Typography } from '@mui/material';
import { Link, useNavigate } from 'react-router-dom';
import { clearCart } from './../../store/cartSlice';
import { setOrderNumber } from './../../store/orderSlice';

function Checkout() {
	const dispatch = useDispatch();
	const navigate = useNavigate();
	const cartItems = useSelector((state) => state.cart.items);
	const totalQuantity = cartItems.reduce((total, item) => total + item.quantityToOrder, 0);

  const calculateTotalSum = () => {
    return cartItems.reduce((total, item) => total + item.price * item.quantityToOrder, 0);
  };

	const formatPrice = (price) => {
		return price.toFixed(2);
	};

	// State for Shipment Info form
	const [shipmentInfo, setShipmentInfo] = useState({
		firstName: '',
		lastName: '',
		email: '',
		address: '',
		address2: '',
		city: '',
		postalCode: '',
		country: '',
	});

	// Extracting id and quantityToOrder for each cartItem
	const itemsInfo = cartItems.map((item) => ({
		id: item.id,
		quantityToOrder: item.quantityToOrder,
	}));

	const handleInputChange = (e) => {
		const { name, value } = e.target;
		setShipmentInfo((prevInfo) => ({
			...prevInfo,
			[name]: value,
		}));
	};

	
	const handleConfirmOrder = () => {
		// Handle the logic for confirming the order with shipmentInfo
		console.log('Shipment Info:', shipmentInfo);
		console.log('Cart Items:', itemsInfo);
		// Submit the form, get order number from backend and navigate with it to OrderConfirmation page 
		const mockOrderNumber = 934657369; // mocked orderNumber, replace it with real from backend
		dispatch(setOrderNumber(mockOrderNumber));
		// navigate(`/orderconfirmation/${mockOrderNumber}`);
		navigate('/orderconfirmation');
		// You can dispatch an action or perform further actions here
		dispatch(clearCart());
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
			<Box sx={{ px: 3, py: 3, flexBasis: '100%' }}>
				<Breadcrumbs sx={{mb: 1}} separator="›" aria-label="breadcrumb">
					<Link underline="hover" color="inherit" to="/">
						Home
					</Link>
					<Typography color="text.primary">Checkout</Typography>
				</Breadcrumbs>
				<Typography variant='h4' component="h1">Checkout</Typography>
				<Box sx={{ display: 'flex', justifyContent: 'flex-end', marginBottom: 1 }}>
					<div>
						<Typography variant="h6" component="div" textAlign='right'>Total items: {totalQuantity}</Typography>
						<Typography variant="h6" component="div" textAlign='right'>Total Sum: ${formatPrice(calculateTotalSum())}</Typography>
					</div>
				</Box>
				<Typography variant='h5' component="h2" mb={2}>Shipment Info</Typography>
				
				<Box component="form" aria-label='Shipment Info' autoComplete="off">
					<Grid container spacing={2}>
						<Grid item xs={12} sm={6}>
							<FormControl fullWidth>
								<TextField
									required
									label="First Name"
									id="firstName"
									name="firstName"
									variant="standard"
									value={shipmentInfo.firstName}
									onChange={handleInputChange}
								/>
							</FormControl>
						</Grid>
						<Grid item xs={12} sm={6}>
							<FormControl fullWidth>
								<TextField
									required
									label="Last Name"
									id="lastName"
									name="lastName"
									variant="standard"
									value={shipmentInfo.lastName}
									onChange={handleInputChange}
								/>
							</FormControl>
						</Grid>
						<Grid item xs={12} sm={6}>
							<FormControl fullWidth>
								<TextField
									required
									label="Email"
									id="email"
									name="email"
									type="email"
									variant="standard"
									value={shipmentInfo.email}
									onChange={handleInputChange}
								/>
							</FormControl>
						</Grid>
						<Grid item xs={12} sm={6}>
							<FormControl fullWidth>
								<TextField
									required
									label="Address"
									id="address"
									name="address"
									variant="standard"
									value={shipmentInfo.address}
									onChange={handleInputChange}
								/>
							</FormControl>
						</Grid>
						<Grid item xs={12} sm={6}>
							<FormControl fullWidth>
								<TextField
									label="Address 2"
									id="address2"
									name="address2"
									variant="standard"
									value={shipmentInfo.address2}
									onChange={handleInputChange}
								/>
							</FormControl>
						</Grid>
						<Grid item xs={12} sm={6}>
							<FormControl fullWidth>
								<TextField
									required
									label="City"
									id="city"
									name="city"
									variant="standard"
									value={shipmentInfo.city}
									onChange={handleInputChange}
								/>
							</FormControl>
						</Grid>
						<Grid item xs={12} sm={6}>
							<FormControl fullWidth>
								<TextField
									required
									label="Postal Code"
									id="postalCode"
									name="postalCode"
									variant="standard"
									value={shipmentInfo.postalCode}
									onChange={handleInputChange}
								/>
							</FormControl>
						</Grid>
						<Grid item xs={12} sm={6}>
							<FormControl fullWidth>
								<TextField
									select
									required
									label="Country"
									id="country"
									name="country"
									value={shipmentInfo.country}
									onChange={handleInputChange}
									variant="standard"
									SelectProps={{
										native: true,
									}}
								>
									<option value=""></option>
									<option value="poland">Poland</option>
									<option value="usa">USA</option>
									<option value="canada">Canada</option>
								</TextField>
							</FormControl>
						</Grid>
					</Grid>

					<Box sx={{ display: 'flex', justifyContent: 'flex-end', mt: 2 }}>
						<Button
							component={Link}
							size="large"
							variant="outlined"
							color="primary"
							to="/cart"
							sx={{ mr: 1 }}
						>
							Back to Cart
						</Button>
						<Button
							component={Link}
							size="large"
							variant="contained"
							color="primary"
							to={'/orderconfirmation'}
							onClick={handleConfirmOrder}
						>
							Confirm Order
						</Button>
					</Box>
				</Box>
			</Box>
		</Box>
	);
}

export default Checkout;

